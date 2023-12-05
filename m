Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF8804C75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjLEIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjLEIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:33:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8679C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:33:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F70BC433C8;
        Tue,  5 Dec 2023 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701765203;
        bh=ls7QYnZoAsXnjVPCwoKCbFvmyNk3iEr0faVWrH3Pvvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXUzwDjhgMKrEoQNQA0omHhVrcA1hxx3hKQ2pvWeCjCtAfeNYGxw0gb2c+psRC1Wg
         pV/1UGp9P6hZhOHELAM5sAwHSe7INAWYL0AVLO4ZgfKOlWLYD/dYrS9OY+t36YAm3R
         51xKkGcHza0uPqNZ3IsH6l0/wO6uW3kHRp0vpSuqyV13XdjBkuUzikQrxLB3h3QFtJ
         2n3vIXhtbbNlMmRvLx1mwlJhR6rHqFm44j0Nx67iRZnvAqHO7AwXIRZl944eCgT8lT
         2PvfTWNI39JH9y2mYLH3t0cH5hJrVVGbNvyiM5b50yeCqWXQzqjzrmYiO2WxXemn9T
         ZMkkeuy3xLPew==
Date:   Tue, 5 Dec 2023 16:33:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: freescale: debix-som-a-bmb-08: Add CSI
 Power Regulators
Message-ID: <20231205083311.GB236001@dragon>
References: <20231127124037.888597-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127124037.888597-1-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:40:34PM +0000, Kieran Bingham wrote:
> Provide the 1.8 and 3.3 volt regulators that are utilised on the Debix
> SOM BMB-08 base board.
> 
> Facilitate this by also supplying the pin control used to enable the
> regulators on the second MIPI CSI port.
> 
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Applied, thanks!
