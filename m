Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1AB7ABC03
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjIVWwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIVWwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:52:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA027AB;
        Fri, 22 Sep 2023 15:52:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EB9C433C7;
        Fri, 22 Sep 2023 22:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695423159;
        bh=WpOE5/YOMJhoOrRKC3VTuOefYY+YCBJ0gqxE+bPM+M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMU06/uZQoE7+sMmxCUfnkaIc4TbQPw+xy1evSjIiX21OrPo1IYOmUn2r3SUCYQkm
         QjSiluwmbtqxuEfGHRSs2VWH7LOeJoXRuW3WiiPkHVs50qu0idnALp7V1XsWalZZmT
         u/GSeT5H721/K/z2aOgETtz4BD2REKdWl6332N3DEZIN0eSuCmEt8PhP40E8UvmTi7
         P8T6ATfWIHTf9AeK5No1lLcfsrdF8CiOejhLo/eusnPEv7xbfODCOXJT0O91SO8jPi
         tO98bE0pF7sRnvPt2MMlGcAi94RWbOGCZj//WSW8a7xg4cvQI/6/tZwt3n/X7MWxVN
         pGGQ73Zi6lufA==
Received: (nullmailer pid 4077777 invoked by uid 1000);
        Fri, 22 Sep 2023 22:52:37 -0000
Date:   Fri, 22 Sep 2023 17:52:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: qcom,msm8226: Add blsp_i2c6
 function
Message-ID: <169542315692.4077737.2123562166324056718.robh@kernel.org>
References: <20230922-msm8226-i2c6-v2-0-3fb55c47a084@z3ntu.xyz>
 <20230922-msm8226-i2c6-v2-1-3fb55c47a084@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-msm8226-i2c6-v2-1-3fb55c47a084@z3ntu.xyz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 18:55:12 +0200, Luca Weiss wrote:
> Add the blsp_i2c6 function that can be found on some pins.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

