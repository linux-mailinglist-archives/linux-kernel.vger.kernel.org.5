Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84BA7F9751
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjK0Bx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjK0Bx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:53:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F26E5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:53:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B805C433C8;
        Mon, 27 Nov 2023 01:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701050013;
        bh=OEqKK0tbtP/SkoTJhodkC5NQeA23JuN3NIViCovSEwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7GV5OMEh/b0RR8GjNvcbyBdHHfvNnLsbtAzZnQkUsFKL86mDwQUB/T8mRRaQJXVD
         /J9cUuym+hStubiyaQh5qtrr8tn+cvCMWMBt6MFJw17KtYUNRoKZ0utGQ1xMtMa2iR
         sMlksf0adXwoY8DxJymFZ71GQBUUmj6GjKhiZpdwWxBrrr8IibwUL01m9K0DTXAUpv
         bl0y58FJbmT4yXErn+iavIV80+O26TzJ4PSRfRi1/PrKJ7XWIeFkeuGGtJq/UzdPRX
         sjcT9dI6xJRrKkCDpyz/pOAg0l0I1T4aTxadXdSbjGI0ZnsB0FwkxJ9zad8+XWHFcx
         x4XK/tNnVKk/w==
Date:   Mon, 27 Nov 2023 09:53:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon-kit: Enable DSI to HDMI Bridge
Message-ID: <20231127015326.GG87953@dragon>
References: <20231013014117.124202-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013014117.124202-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:41:17PM -0500, Adam Ford wrote:
> The baseboard of the Beacon i.MX8M Plus development kit has
> an ADV7535 DSI to HDMI bridge capable of stereo sound.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
