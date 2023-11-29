Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A67FD60A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjK2Lui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjK2Lue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:50:34 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D8D65
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:50:40 -0800 (PST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8J5N-0006oE-ML; Wed, 29 Nov 2023 12:50:33 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231128214759.3975428-1-robh@kernel.org>
References: <20231128214759.3975428-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: reset: hisilicon,hi3660-reset: Drop
 providers and consumers from example
Message-Id: <170125863155.1536676.7072293092742736141.b4-ty@pengutronix.de>
Date:   Wed, 29 Nov 2023 12:50:31 +0100
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

On Tue, 28 Nov 2023 15:47:58 -0600, Rob Herring wrote:
> Binding examples should generally only cover what the binding covers. A
> provider binding doesn't need to show consumers and vice-versa. The
> hisilicon,hi3660-reset binding example has both, so let's drop them.
> 
> This also fixes an undocumented (by schema) compatible warning for
> "hisilicon,hi3660-iomcu".
> 
> [...]

Applied to reset/next, thanks!

[1/1] dt-bindings: reset: hisilicon,hi3660-reset: Drop providers and consumers from example
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=c3c46acd5be9

regards
Philipp

