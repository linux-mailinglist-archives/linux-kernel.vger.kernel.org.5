Return-Path: <linux-kernel+bounces-7515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE881A920
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CB21C22B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728D4B128;
	Wed, 20 Dec 2023 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyYP3uKg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FD4AF8A;
	Wed, 20 Dec 2023 22:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37457C433C9;
	Wed, 20 Dec 2023 22:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703111209;
	bh=WJnGAatmmvwEdsZ5rkU/K/qmztZ8dETfW4vPPQhhOL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyYP3uKgfarfuxHl4WY/auy0gcdSKPENg20U93VA1LLzJs5fQZbw7E9Wd9HEsZCBw
	 IvW7LNs0skIwNQPaqlK0VABLLtm0ONLkJ9cqYJ7a64IGtIBRS3Nforh+/z91hRsUcS
	 ITzgAKJNKFdDdSdfTHUTBPWiS3yRW0LgfpeC/ATDWFIdX+YrADB1C6sLXrO1zKOGSl
	 Jg/CHYsYhGAE//8824MkITnj/YlrdWji+ZP7zwxPb/m8SU37UaaOiGm3apK8LgcK8Y
	 BJp4IWj4tfhyPK9M8v31+vMPb6eHlnKlzUi4SsST+PeXP2RkoHrZvu4xa4cq+flcsV
	 z8c3x1HVL9lyg==
Received: (nullmailer pid 1237303 invoked by uid 1000);
	Wed, 20 Dec 2023 22:26:47 -0000
Date: Wed, 20 Dec 2023 16:26:47 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix
 path to header
Message-ID: <170311120672.1237253.11755935355302522816.robh@kernel.org>
References: <20231218130553.45893-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218130553.45893-1-krzysztof.kozlowski@linaro.org>


On Mon, 18 Dec 2023 14:05:53 +0100, Krzysztof Kozlowski wrote:
> Fix the path to bindings header in description.
> 
> Fixes: e1c4c5436b4a ("dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp binding")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml           | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


