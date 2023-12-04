Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86E58034E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjLDN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjLDN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:28:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B281949CE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:26:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA0EC433C7;
        Mon,  4 Dec 2023 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701696393;
        bh=+KG3xcZFmyTIbsERfnkP9uoq6hpeNKXxUGzii+pc5Zo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MyhnU/JhrifVCtFAvZAaYK6Y9cw5Vffz3K+2EC9PP5lRzheWG2PAp4XgT2kLwsdth
         qYXPaixNhYL6tMgiJg2PZm9IN9rXzOK7DLy1Pa7gn+kcCZTeU7CMDC3y06FrduxrlJ
         Tw2BdGbxlPgbjXLP2ecMpyKHaAIb7SRbHGgaOoxb10e13M7g0aETR0KR+y6/EV3AlV
         imj55cWAPTTfDkUaReH3tVJiaLVmdUsO85vhrc5G6sxWQGanKlbS32pFs41KaSVmH9
         wLFi6CNym5n3Puk5H4LvFJYwPFMwKDCPFOSxt0piuHwjKpMIdiT+SxNlL3VAv3ovG6
         E2IJ2r99vayAQ==
Date:   Mon, 4 Dec 2023 13:26:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: iio/adc: qcom,spmi: fix up examples
Message-ID: <20231204132624.03733d50@jic23-huawei>
In-Reply-To: <20231130171628.12257-1-johan+linaro@kernel.org>
References: <20231130171628.12257-1-johan+linaro@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 18:16:22 +0100
Johan Hovold <johan+linaro@kernel.org> wrote:

> When reviewing the various SPMI PMIC bindings, I noticed that several
> examples were incorrect and misleading and could also use some cleanup.
> 
> This series addresses the iio/adc ones.

All look fine to me.  Just waiting for the DT folk to have time to take a look.
> 
> Johan
> 
> 
> Johan Hovold (6):
>   dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
>   dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
>   dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
>   dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
>   dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
>   dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples
> 
>  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml    | 10 ++++++----
>  .../devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml   |  4 ++--
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml    |  9 +++++----
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 

