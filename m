Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013527F3007
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjKUOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjKUOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:00:21 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F88D6F;
        Tue, 21 Nov 2023 06:00:16 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 2CE662065C;
        Tue, 21 Nov 2023 15:00:15 +0100 (CET)
Date:   Tue, 21 Nov 2023 15:00:10 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Joe Hung <joe_hung@ilitek.com>
Subject: Re: [PATCH v2 0/2] Input: ilitek_ts_i2c - Fix spurious input events
Message-ID: <ZVy36u1RtAg7Mqme@francesco-nb.int.toradex.com>
References: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
 <ZTU7_ICOgw9tka8I@livingston.pivistrello.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTU7_ICOgw9tka8I@livingston.pivistrello.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Sun, Oct 22, 2023 at 05:13:00PM +0200, Francesco Dolcini wrote:
> On Wed, Sep 20, 2023 at 09:46:48AM +0200, Emanuele Ghidoli wrote:
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > 
> > A couple of fixes to prevent spurious events when the data buffer is not the expected one.
> > 
> > Emanuele Ghidoli (2):
> >   Input: ilitek_ts_i2c - avoid wrong input subsystem sync
> >   Input: ilitek_ts_i2c - add report id message validation
> > 
> >  drivers/input/touchscreen/ilitek_ts_i2c.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Just a gently ping on this series.

Apologize for nagging you again on this small series, I assume it just
got lost through the cracks, but if this is not the case and you need
anything just let me know.

Thanks,
Francesco

