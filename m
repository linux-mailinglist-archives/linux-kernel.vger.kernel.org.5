Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A159809A19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjLHDO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjLHDO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:14:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E12410CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:14:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF22C433C7;
        Fri,  8 Dec 2023 03:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702005272;
        bh=i6QahoY2i38BfqMi3CMYz8694XkKFslWp28QY+7R8so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oB/Kt1MUzpve4cuyWfLwcdPfWPjfKd1brAJqAdcmDB45PNmSarB7vHpg2mc1nFKaS
         C/Ei/enQhoa6E1+VoLGO4tIkdDJ7U3oS+HgTwN6jNdpuMEEdwylL3aI6U8DhFqyd2u
         Xs7nMqoUpvY+qAgCO/Si4DR9LkaqwKM0j3nBAtxSMzq/17Fg6diykAjusr/E047o7+
         vQpbsDL+yPW7fsACxlY2ljO7IB00BlPYZDLUpSzhC2AExFHx3z/hBha7cxNH1pW4xP
         /Biy1XyydK/9QGic6jAkKlM3nDPPfSNwJyi7Y9UUOZFoDZY1UQA/SWrEky7IHbfesb
         Sc17wN/CHXqyw==
Date:   Thu, 7 Dec 2023 19:19:08 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v2 0/2] interconnect: qcom: Introduce support for SM8650
Message-ID: <36ip3gmodvx2afl2lbdphyevzmo2nwcujnlie3njj5d36kwdeh@qzo43f5g3a52>
References: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
 <7fbe4090-94cd-4aaf-98b6-07f2a089d51a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fbe4090-94cd-4aaf-98b6-07f2a089d51a@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:08:37PM +0200, Georgi Djakov wrote:
> On 23.11.23 15:32, Neil Armstrong wrote:
> > This covers the RPMh Network-On-Chip Interconnect bindings
> > and driver for the interconnect framework.
> 
> Thanks Neil!
> 
> > As reported for earlier Interconnect drivers, the IDs
> > for multi-rsc voting has been removed from this driver
> > so the proper solution can be developed without having
> > to remove entries later on.
> > 
> > To easy Bjorn into merging the DT bits, would it be possible
> > to have an immutable branch with bindings shared with Bjorn once
> > this patchset have been properly reviewed and accepted ?
> 
> Hi Bjorn,
> 
> Here is a stable branch with the DT bindings header that might be needed
> for SM8650 dts patches.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm8650
> 

Very nice, thank you Georgi

Regards,
Bjorn
