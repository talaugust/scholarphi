import classNames from "classnames";
import React from "react";
import { SectionHeader } from "../../../api/types";
import { PDFPageView } from "../../../types/pdfjs-viewer";
import * as uiUtils from "../../../utils/ui";

/* simple gloss that displays simplified version of a highlighted section
Because we want the gloss to always show some information in the sidebar,
Use the full entity annotation here and render the gloss next to the underline
*/
interface Props {
  entity: SectionHeader;
  pageView: PDFPageView;
  shouldFlip: boolean;
}

export default class SectionHeaderImage extends React.PureComponent<Props, {}> {
  render() {
    const boundingBoxes = this.props.entity.attributes.bounding_boxes;

    // console.log(this.props.entity);
    // update so to the side of the text
    // boundingBoxes.map((box) => {box['left'] = box['left']});

    const pos = uiUtils.getPositionInPageView(
      this.props.pageView,
      boundingBoxes[0]
    );

    const imgClass = this.props.shouldFlip
      ? "section-header-annotation-img-flipped"
      : "section-header-annotation-img";
    return (
      <div
        className={classNames("scholar-reader-annotation-span", imgClass)}
        style={{ left: pos.left, top: pos.top, width: "30px", height: "22px" }}
      ></div>
    );
  }
}
