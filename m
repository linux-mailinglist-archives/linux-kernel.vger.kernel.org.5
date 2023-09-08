Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF3798985
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbjIHPEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIHPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:04:36 -0400
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [IPv6:2a02:1800:110:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C71FC0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:04:32 -0700 (PDT)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4Rhzsp3Sh6z4wyHk
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 17:04:30 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by laurent.telenet-ops.be with bizsmtp
        id jT4W2A0052mGBSJ01T4WhL; Fri, 08 Sep 2023 17:04:30 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qed26-002pMc-7N;
        Fri, 08 Sep 2023 17:04:30 +0200
Date:   Fri, 8 Sep 2023 17:04:30 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
cc:     linux-renesas-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] i2c: rcar: properly format a debug output
In-Reply-To: <20230906200024.5305-3-wsa+renesas@sang-engineering.com>
Message-ID: <beac67f9-4bc3-edc8-72a4-551755a8128@linux-m68k.org>
References: <20230906200024.5305-1-wsa+renesas@sang-engineering.com> <20230906200024.5305-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2023, Wolfram Sang wrote:
> Use proper types and spacing.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
