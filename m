Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3BE7D577E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbjJXQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjJXQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:10:04 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89D8910C2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:10:00 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39OG9dT3004051;
        Tue, 24 Oct 2023 18:09:39 +0200
Date:   Tue, 24 Oct 2023 18:09:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Use linux/wait.h rather than
 duplicating it
Message-ID: <ZTfsQw3T5VP/LXQv@1wt.eu>
References: <20231023-nolibc-waitpid-flags-v2-1-b09d096f091f@kernel.org>
 <d5d7dcdf-11d7-4bfb-9aeb-c440394ddfc4@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5d7dcdf-11d7-4bfb-9aeb-c440394ddfc4@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 05:59:13PM +0200, Thomas Weiﬂschuh  wrote:
> Thanks!
> 
> Oct 23, 2023 20:42:52 Mark Brown <broonie@kernel.org>:
> 
> > Linux defines a few custom flags for waitpid() which aren't currently
> > provided by nolibc, make them available to nolibc based programs by just
> > including linux/wait.h where they are defined instead of defining our
> > own copy of the flags.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> I can apply it, but only next week.

Yeah I'm fine as well, thanks Mark for this. I'm still too short on
time these days but if I manage to upload it sooner, I'll let you know.

Thanks!
Willy
