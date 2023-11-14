Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810227EAAED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjKNHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNHdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:33:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398BCC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:33:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB654C433C8;
        Tue, 14 Nov 2023 07:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699947191;
        bh=1jPXW/9gsRNCRI/ogL17H5SYbGmYFfttaj3ESSTXmIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQIIt++75FqOoAjUbylKmvaXsmHoCIQCguESRHUl38xhUoNOsZ/w1obOtqc9vXYp6
         f/uD49221oPiVMZfY7mtL1S+DV6Gnhcj/XYliwMnOJKdi8opCJWsQ64GBBwH53V5bO
         VNjYY+rj+8fhGjJHKlp56dEbLrpYO8PPEK+lMyNOAkNB03+qkSki1yJNKabxydCnP5
         MhodKFDm0h5pdkIuHMKV3kmje8qa94dDbw1xN0cy8T/tX+TBibB4aizub73HmeNYcU
         f7eT7/RP50SEuw7aAdodCUM88zUgWY5fmk1Ml7FnWHzJwXIIKt9VxVbGmBi57JeIwq
         QAyFtZcllQ2lA==
Date:   Tue, 14 Nov 2023 13:03:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845: correct Soundwire node name
Message-ID: <ZVMis75+dhUdm3iI@matsya>
References: <20231111095617.16496-1-krzysztof.kozlowski@linaro.org>
 <20231111095617.16496-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111095617.16496-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-23, 10:56, Krzysztof Kozlowski wrote:
> Soundwire Devicetree bindings expect the Soundwire controller device
> node to be named just "soundwire":
> 
>   sdm845-db845c.dtb: swm@c85: $nodename:0: 'swm@c85' does not match '^soundwire(@.*)?$'

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
