Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A678A7AB6A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjIVQ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIVQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:59:45 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE64A1;
        Fri, 22 Sep 2023 09:59:38 -0700 (PDT)
Received: from g550jk.localnet (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 18589CFADA;
        Fri, 22 Sep 2023 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695401947; bh=YdDNYeicK1mKk1zXR9XTDGgIPaGTsOQEJqBY4ITj1lA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LBedKGnqOSjfpR9SN7Cxj2UmD11nuc5bPBvw1EWYjnGzHMetMP7n2tlT3qtMCLWRJ
         hAnlUisNVUdobBhO3BANmrETiyOkG5SqHtTWPhKqG11rCZL1XddGS5rlbQKSlkEuG6
         EDcDfDwsKN6Y9/pInpZgjfYY9V3QzAHFrJbhETVo=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Small style fixes in msm8974.dtsi
Date:   Fri, 22 Sep 2023 18:59:06 +0200
Message-ID: <2899653.e9J7NaK4W3@z3ntu.xyz>
In-Reply-To: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
References: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 27. Juni 2023 21:45:12 CEST Luca Weiss wrote:
> While making sure the nodes are sorted correctly, I also noticed that
> some lines are wrongly indented. Fix both.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Luca Weiss (2):
>       ARM: dts: qcom: msm8974: replace incorrect indentation in interconnect
> ARM: dts: qcom: msm8974: sort nodes by reg
> 
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 80
> ++++++++++++++++---------------- 1 file changed, 40 insertions(+), 40
> deletions(-)
> ---
> base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
> change-id: 20230627-msm8974-sort-e34b28f10a34
> 
> Best regards,

Hi Bjorn,

also ping on this one. I didn't check again if it now conflicts with -next (as 
pointed out by Konrad a while ago), if it does let me know and I'll resend.

Regards
Luca


