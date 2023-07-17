Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E348755D15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGQHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGQHh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:37:58 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80901E7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:37:57 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36H7bdVh028814;
        Mon, 17 Jul 2023 09:37:39 +0200
Date:   Mon, 17 Jul 2023 09:37:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     shijie001@208suo.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Fix warnings in ctype.h
Message-ID: <ZLTvw9LECpoksakO@1wt.eu>
References: <tencent_17E97603EBEAD2CF4830CCE529421ED7BF05@qq.com>
 <ca6e44ee0e6bd01abd31415c986aa269@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6e44ee0e6bd01abd31415c986aa269@208suo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 17, 2023 at 03:18:50PM +0800, shijie001@208suo.com wrote:
> The following checkpatch warnings are removed:
> WARNING: __always_unused or __maybe_unused is preferred over
> __attribute__((__unused__))

Thanks but that's userland code, which doesn't have access to the kernel
macros, hence this usage.

Regards,
willy
