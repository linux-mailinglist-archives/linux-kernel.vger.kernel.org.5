Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0D784BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjHVVNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHVVNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668D4CE2;
        Tue, 22 Aug 2023 14:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2E3634E2;
        Tue, 22 Aug 2023 21:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330F0C433C8;
        Tue, 22 Aug 2023 21:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692738788;
        bh=eRYIalTR42stPObN9XcLhohHyqTZK7rj0I3RMu/SSPE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MIN1JOVVuP8dHW75nLTc3IzpqPSNJ33T9+Bek0Jzp+/gQaifwqBVakAesUDm5deYK
         741Nfas4h6m4fM7e0mNb5ZCKxUrUvpZKA6osrYvXCa2K0OfOJZN8YL2iTXfGUht/hm
         ZGFm05PsBehz8URvxq3ftBGkHvldAHzvKncvSas4Bxq8pllCldT2E6yjowZLzPGRmn
         XP3mteibLg3tnGfAVwClyC8zU4s5SJ7d1pRQ0OIZdIL0uJZMtrOLpPUr1bRcxZsWxB
         5STvrb2iy2iZkjpTR+z8rsqRUo5x13+SxrEVKm27/tM8OFSKb0KXmIrHtTWgH6S9Li
         zDewK+U0nh45w==
Message-ID: <6782047c048d92aac638165bb88664fe.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230804-drop-old-mmp-clk-v1-1-0c07db6cee90@skole.hr>
References: <20230804-drop-old-mmp-clk-v1-1-0c07db6cee90@skole.hr>
Subject: Re: [PATCH] clk: mmp: Remove old non-OF clock drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 22 Aug 2023 14:13:05 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Duje Mihanovi=C4=87 (2023-08-04 06:49:32)
> There are no MMP2, PXA168 or PXA910 boards still using board files which
> would use these drivers, so remove them.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---

Applied to clk-next
