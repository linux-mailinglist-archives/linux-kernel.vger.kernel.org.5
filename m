Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92913804C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbjLEIWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEIWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:22:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03571127
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:22:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDF7C433C8;
        Tue,  5 Dec 2023 08:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701764559;
        bh=+w4rpqhtSR+s5A03cf3EOv0DwUJgODGWLjcd0BmHnAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlezlPRFkDvK7uCFQ2fLhwkwWZ+jC56bkgyXn75X6ixNKdP/uxaR7+vxoyJHAaLzi
         AwmIoFGbgq1L1EF/P2bfO/ffVoyPopfF83smXa2VTw67aJ3LGx4OLM2QbJHi6aXeIu
         ik69THuD2A9C2iEP5rIrAV4kag4QHo8sbpxR1701UlBuKJi3FCpLxrdAHz6+7WaO4q
         If9ZjRU2eeSzZJSjpME6o0KLPHwjS0vc0Rx1HML+qprJbktV87ZjoyXNUcQ9H+e0uu
         +ldFacG7+wKSUPw9YdakurYHp1cVT+m8t+b6SKtGlB3Dw5xYAVI1bt4/7gDVIibbj9
         M/boBUCVnNx2Q==
Date:   Tue, 5 Dec 2023 16:22:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1 0/2] imx6/imx8-apalis: add can power-up delay on ixora
 board
Message-ID: <20231205082233.GA236001@dragon>
References: <20231020153022.57858-1-andrejs.cainikovs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020153022.57858-1-andrejs.cainikovs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:30:20PM +0200, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> Newer variants of Ixora boards require a power-up delay when powering up
> the CAN transceiver of up to 1ms. This series adds mentioned delay for
> iMX6 and iMX8 Apalis SoM variants.
> 
> Andrejs Cainikovs (2):
>   arm64: dts: imx8-apalis: add can power-up delay on ixora board
>   ARM: dts: imx6q-apalis: add can power-up delay on ixora board

Applied both, thanks!
