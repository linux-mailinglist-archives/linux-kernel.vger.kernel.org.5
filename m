Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E385176C941
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjHBJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjHBJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:16:56 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68730F4;
        Wed,  2 Aug 2023 02:16:26 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 617561F83F;
        Wed,  2 Aug 2023 11:16:20 +0200 (CEST)
Date:   Wed, 2 Aug 2023 11:16:13 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jai Luthra <j-luthra@ti.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 0/3] clk: keystone: syscon-clk: fixes for audio refclk
Message-ID: <ZMoe3e4eF3Hll1e3@francesco-nb.int.toradex.com>
References: <cover.1690885413.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690885413.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 12:36:06PM +0200, Matthias Schiffer wrote:
> The actual fix is in patch 3; patches 1 and 2 are preparation and
> related cleanup. I've added a Fixes: tag to all 3 patches, as they
> need to be backported together.

Please see this https://lore.kernel.org/all/20230728222639.110409-1-francesco@dolcini.it/
that was sent a few days ago. It fixes the same issue and it's already
reviewed.

Francesco

