Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340F279D815
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbjILRxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbjILRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:53:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136B1702;
        Tue, 12 Sep 2023 10:52:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DC4C433C8;
        Tue, 12 Sep 2023 17:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541168;
        bh=HPcDqNLUFypCc5Q7NZiB8Hj54QddwKqz4SmQVlGbckE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRW2fJkeefahF6Te9zAt7FTdeXUh3go1V8qR2BinfO6dOF1LGMrkEjQGg0sbqFVkN
         QvEu6mv8rPssooyA/Y6yVGl0cT+2YyuIxMdkw9dhsvamTi2XJNrji8kZCMKCYmB+Px
         c9F7XkgEqKlsEBKUUR9jp0Ln19fTFW1DmAOOtyncXEEwSU+DttfD+G0y0SLwdJ27YQ
         fg08fnejG9pKx5cop3vAm5A4PdpxF7Q2QV4QOslqx9vuo79B0ziPMJNZvqC6Joepk5
         45BUu6gzgGGy0QWnOIFKJGEmtNV/fyngJ1YOXrlAyA+NNxp2eATs9ioaRiEG0b015p
         K9rCBRDu02qJA==
Received: (nullmailer pid 991353 invoked by uid 1000);
        Tue, 12 Sep 2023 17:52:45 -0000
Date:   Tue, 12 Sep 2023 12:52:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Robert Marko <robimarko@gmail.com>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: Re: [PATCH 1/6] dt-bindings: regulator: qcom,spmi: Document PM8909
Message-ID: <169454116542.991294.13436176994146682244.robh@kernel.org>
References: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
 <20230912-spmi-pm8909-v1-1-ba4b3bfaf87d@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-spmi-pm8909-v1-1-ba4b3bfaf87d@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 09:49:49 +0200, Stephan Gerhold wrote:
> From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> 
> Document the qcom,pm8909-regulators compatible together with the
> necessary supply properties to allow interfacing via the hardware
> regulator registers directly via SPMI. This is mainly intended for
> debugging since the regulators are typically controlled via the RPM
> firmware (qcom,rpm-pm8909-regulators compatible).
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.yaml       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

