Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0937C6634
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbjJLHGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343567AbjJLHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:06:42 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8855F90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:06:40 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39C76Xsb005111;
        Thu, 12 Oct 2023 09:06:33 +0200
Date:   Thu, 12 Oct 2023 09:06:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <ZSea+etQwlxbi+Ok@1wt.eu>
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Oct 12, 2023 at 01:13:37AM +0200, Thomas Weiﬂschuh wrote:
> While uncommon, nolibc executables can be linked together from multiple
> compilation units.
> Add some tests to make sure everything works in that case.
(...)

Glad you did these two. Your approach is good and it remains easy to
use and should catch next breakage in this area.

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Note:
> 
> This depends on path "tools/nolibc: mark start_c as weak".
> https://lore.kernel.org/lkml/20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net/

For these two patches: Acked-by: Willy Tarreau <w@1wt.eu>

Thanks
Willy
