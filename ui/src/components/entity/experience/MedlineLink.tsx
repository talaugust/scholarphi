import React from "react";

interface Props {
  url: string;
}

/**
 * Link to a Medline resource.
 */
class MedlineLink extends React.PureComponent<Props, {}> {
  render() {
    return <p>retrieved from {this.props.url} </p>;
  }
}

export default MedlineLink;
