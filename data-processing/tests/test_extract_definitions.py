import pytest

from entities.definitions.commands.detect_definitions import *


@pytest.fixture(scope="module", autouse=True)
def setup_model():
    """
    Only set up the model once, as it requires the time-consuming initialization
    """
    global model  # pylint: disable=global-statement
    model = DefinitionDetectionModel()


def test_extract_term_definition_pairs_case_1():
    # Case 1: Definition before the term.
    text = "The technique of learning the underlying data distribution function given labelled examples is known as Supervised Learning in ML literature."
    gold = [("Supervised Learning","The technique of learning the underlying data distribution function given labelled examples")]
    featurized_text = model.featurize(text)
    features = [featurized_text]
    intents, slots, slots_confidence = model.predict_batch(
        cast(List[Dict[Any, Any]], features)
    )
    term_definition_pairs = get_term_definition_pairs(
        text, features[0], slots[0], slots_confidence[0]
    )
    assert len(term_definition_pairs) == len(
        gold
    ), "Incorrect number of Term-Definitions"
    for prediction_pair, gold_pair in zip(term_definition_pairs, gold):
        assert (
            text[prediction_pair.term_start : prediction_pair.term_end] == gold_pair[0]
        ), "Term Incorrect"
        assert (
            text[prediction_pair.definition_start : prediction_pair.definition_end]
            == gold_pair[1]
        ), "Definition Incorrect"


def test_extract_term_definition_pairs_case_2():
    # Case 2: Definition after the term.
    text = "We evaluate our model on SQuAD, a reading comprehension dataset consisting of questions posed by crowdworkers on a set of Wikipedia articles."
    gold = [
        (
            "SQuAD",
            "a reading comprehension dataset consisting of questions posed by crowdworkers on a set of Wikipedia articles",
        )
    ]
    featurized_text = model.featurize(text)
    features = [featurized_text]
    intents, slots, slots_confidence = model.predict_batch(
        cast(List[Dict[Any, Any]], features)
    )
    term_definition_pairs = get_term_definition_pairs(
        text, features[0], slots[0], slots_confidence[0]
    )
    assert len(term_definition_pairs) == len(
        gold
    ), "Incorrect number of Term-Definitions"
    for prediction_pair, gold_pair in zip(term_definition_pairs, gold):
        assert (
            text[prediction_pair.term_start : prediction_pair.term_end] == gold_pair[0]
        ), "Term Incorrect"
        assert (
            text[prediction_pair.definition_start : prediction_pair.definition_end]
            == gold_pair[1]
        ), "Definition Incorrect"


def test_extract_symbol_nickname_pairs_case_1():
    # Case 1: Nickname before symbol.
    text = "The agent acts with a policy SYMBOL in each timestep SYMBOL."
    tex = "The agent acts with a policy [[FORMULA:\pi]] in each timestep [[FORMULA:t]]"
    gold = [("\pi", "policy"), ("t", "timestep")]
    featurized_text = model.featurize(text)
    features = [featurized_text]
    symbol_texs = get_symbol_texs(text, tex)
    symbol_nickname_pairs = get_symbol_nickname_pairs(text, features[0], symbol_texs)
    assert len(symbol_nickname_pairs) == len(
        gold
    ), "Incorrect number of Symbol-Nicknames"
    for prediction_pair, gold_pair in zip(symbol_nickname_pairs, gold):
        if symbol_texs is not None and prediction_pair.term_start in symbol_texs:
            assert (
                symbol_texs[prediction_pair.term_start] == gold_pair[0]
            ), "Symbol Incorrect"
        else:
            assert (
                text[prediction_pair.term_start : prediction_pair.term_end]
                == gold_pair[0]
            ), "Symbol Incorrect"
        assert (
            text[prediction_pair.definition_start : prediction_pair.definition_end]
            == gold_pair[1]
        ), "Nickname Incorrect"


def test_extract_symbol_nickname_pairs_case_2():
    # Case 2: Nickname after symbol.
    text = "The architecture consists of SYMBOL dense layers trained with SYMBOL learning rate."
    tex = "The architecture consists of [[FORMULA:L_d]] dense layers trained with [[FORMULA:\alpha]] learning rate."
    gold = [("L_d", "dense layers"), ("\alpha", "learning rate")]
    featurized_text = model.featurize(text)
    features = [featurized_text]
    symbol_texs = get_symbol_texs(text, tex)
    symbol_nickname_pairs = get_symbol_nickname_pairs(text, features[0], symbol_texs)
    assert len(symbol_nickname_pairs) == len(
        gold
    ), "Incorrect number of Symbol-Nicknames"
    for prediction_pair, gold_pair in zip(symbol_nickname_pairs, gold):
        if symbol_texs is not None and prediction_pair.term_start in symbol_texs:
            assert (
                symbol_texs[prediction_pair.term_start] == gold_pair[0]
            ), "Symbol Incorrect"
        else:
            assert (
                text[prediction_pair.term_start : prediction_pair.term_end]
                == gold_pair[0]
            ), "Symbol Incorrect"
        assert (
            text[prediction_pair.definition_start : prediction_pair.definition_end]
            == gold_pair[1]
        ), "Nickname Incorrect"


def test_extract_symbol_nickname_pairs_case_3():
    # Case 3: SYMBOL-th pattern.
    text = "This process repeats for every SYMBOLth timestep."
    tex = "TThis process repeats for every [[FORMULA:k]]th timestep."
    gold = [("k", "timestep")]
    featurized_text = model.featurize(text)
    features = [featurized_text]
    symbol_texs = get_symbol_texs(text, tex)
    symbol_nickname_pairs = get_symbol_nickname_pairs(text, features[0], symbol_texs)
    assert len(symbol_nickname_pairs) == len(
        gold
    ), "Incorrect number of Symbol-Nicknames"
    for prediction_pair, gold_pair in zip(symbol_nickname_pairs, gold):
        if symbol_texs is not None and prediction_pair.term_start in symbol_texs:
            assert (
                symbol_texs[prediction_pair.term_start] == gold_pair[0]
            ), "Symbol Incorrect"
        else:
            assert (
                text[prediction_pair.term_start : prediction_pair.term_end]
                == gold_pair[0]
            ), "Symbol Incorrect"
        assert (
            text[prediction_pair.definition_start : prediction_pair.definition_end]
            == gold_pair[1]
        ), "Nickname Incorrect"


def test_extract_abbreviation_expansion_pairs_case_1():
    # Case 1: Abbreviation in parentheses.
    text = "We use a Convolutional Neural Network (CNN) based architecture in this model, which is an improvement over state-of-the-art."
    gold = [("CNN", "Convolutional Neural Network")]
    featurized_text = model.featurize(text)
    features = [featurized_text]
    abbreviation_pairs = get_abbreviation_pairs(text, features[0], model.nlp)
    assert len(abbreviation_pairs) == len(gold), "Incorrect number of Abbreviations"
    for prediction_pair, gold_pair in zip(abbreviation_pairs, gold):
        assert (
            text[prediction_pair.term_start : prediction_pair.term_end] == gold_pair[0]
        ), "Abbreviation Incorrect"
        assert (
            text[prediction_pair.definition_start : prediction_pair.definition_end]
            == gold_pair[1]
        ), "Expansion Incorrect"


def test_extract_abbreviation_expansion_pairs_case_2():
    # Case 2 : Abbreviation contains multiple lowercase letters.
    text = "We propose a new class of architectures called Conductive Networks (CondNets) in this paper."
    gold = [("CondNets", "Conductive Networks")]
    featurized_text = model.featurize(text)
    features = [featurized_text]
    abbreviation_pairs = get_abbreviation_pairs(text, features[0], model.nlp)
    assert len(abbreviation_pairs) == len(gold), "Incorrect number of Abbreviations"
    for prediction_pair, gold_pair in zip(abbreviation_pairs, gold):
        assert (
            text[prediction_pair.term_start : prediction_pair.term_end] == gold_pair[0]
        ), "Abbreviation Incorrect"
        assert (
            text[prediction_pair.definition_start : prediction_pair.definition_end]
            == gold_pair[1]
        ), "Expansion Incorrect"
