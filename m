Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3C806584
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376353AbjLFDQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:16:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738C1AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:16:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB2DC433C7;
        Wed,  6 Dec 2023 03:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701832581;
        bh=AvI3HsirczffaxE/Kd4YHOpsJCh6hSno31pCLAgizSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uC89yqOBWuAd0B7Tle/fTd9txdx7PiPTBXgiAzUvztjTrjdAdQaAdyD88k4lXSx7I
         4jphlRDkJD3Tmy6F0yLNTXpoLvLMCuzDgC+m0K6xxNNEAYEmls45XZpDZSZ2VTMXsk
         guVz2wllxi1c4DpIQ1ImYepIyP9oSiZar6ywJWc3gTcUtFQ9GIFvrrsdNtEGayixv8
         ycE/HuICMJlYkOFEZWp03zx+WEhWpSPMEWNQWy3A0kWzcs9QIMLze0+xD/uV5ZIYGx
         AlGmLf8Hf+bgccVZ9hOWMTurAnjel2ZgMEV6Vtm9NvZsXMPPua+ICrFK+Qkp2VQ6fF
         D1fIDmqvFWXbA==
Date:   Wed, 6 Dec 2023 11:16:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] arm64: dts: imx8mq-phanbell: make dts use
 gpio-fan matrix instead of array
Message-ID: <20231206031616.GR236001@dragon>
References: <20231202222934.137191-1-david@ixit.cz>
 <20231202222934.137191-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202222934.137191-2-david@ixit.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 11:29:01PM +0100, David Heidelberg wrote:
> No functional changes.
> 
> Adjust to comply with dt-schema requirements
> and make possible to validate values.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied, thanks!
