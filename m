Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7E7F9D36
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjK0KNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjK0KNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:13:42 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F70188;
        Mon, 27 Nov 2023 02:13:45 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id C0FDC206D2;
        Mon, 27 Nov 2023 11:13:39 +0100 (CET)
Date:   Mon, 27 Nov 2023 11:13:34 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM: dts: imx6q-apalis: add can power-up delay on
 ixora board
Message-ID: <ZWRrznJiUyXlzzW1@francesco-nb.int.toradex.com>
References: <20231020153022.57858-1-andrejs.cainikovs@gmail.com>
 <20231020153022.57858-3-andrejs.cainikovs@gmail.com>
 <20231127025218.GR87953@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127025218.GR87953@dragon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:52:18AM +0800, Shawn Guo wrote:
> On Fri, Oct 20, 2023 at 05:30:22PM +0200, Andrejs Cainikovs wrote:
> > From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> > 
> > Newer variants of Ixora boards require a power-up delay when powering up
> > the CAN transceiver of up to 1ms.
> > 
> > Cc: stable@vger.kernel.org
> 
> Why is only the iMX6 change required for stable?

From what I know currently apalis-imx8 is not yet used in products
with a mainline kernel therefore the assumption that the backporting
would add very small value, however maybe is better to just backport
both to stable.

Francesco

