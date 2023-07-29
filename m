Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC93F767CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjG2H22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG2H20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:28:26 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CA9E49D5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:28:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T7SGk7004141;
        Sat, 29 Jul 2023 09:28:16 +0200
Date:   Sat, 29 Jul 2023 09:28:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v1] tools/nolibc/stdio: add setvbuf() to set buffering
 mode
Message-ID: <20230729072816.GE956@1wt.eu>
References: <20230726070655.2713530-1-ryan.roberts@arm.com>
 <a211cedb-8592-4dea-af2a-1818279c66b1@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a211cedb-8592-4dea-af2a-1818279c66b1@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:46:16PM +0100, Mark Brown wrote:
> On Wed, Jul 26, 2023 at 08:06:55AM +0100, Ryan Roberts wrote:
> > Add a minimal implementation of setvbuf(), which error checks the mode
> > argument (as required by spec) and returns. Since nolibc never buffers
> > output, nothing needs to be done.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Looks good and queued, thanks to you both!
Willy
