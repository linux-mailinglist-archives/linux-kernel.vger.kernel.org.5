Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF27FD60B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjK2Lur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjK2Luh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:50:37 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93301A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:50:43 -0800 (PST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8J5L-0006oE-9z; Wed, 29 Nov 2023 12:50:31 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115211829.32542-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231115211829.32542-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl:
 Document RZ/Five SoC
Message-Id: <170125863057.1536676.8251261035131321801.b4-ty@pengutronix.de>
Date:   Wed, 29 Nov 2023 12:50:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 21:18:29 +0000, Prabhakar wrote:
> The USBPHY Control Device on the RZ/Five SoC is identical to one found on
> the RZ/G2UL SoC. "renesas,r9a07g043-usbphy-ctrl" compatible string will be
> used on the RZ/Five SoC so to make this clear and to keep this file
> consistent, update the comment to include RZ/Five SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,rzg2l-usbphy-ctrl" will be used as a fallback on RZ/Five SoC.
> 
> [...]

Applied to reset/next, thanks!

[1/1] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/Five SoC
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=1240070d4e04

regards
Philipp

