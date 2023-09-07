Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8AC7977F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbjIGQhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjIGQhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:37:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614C4ED7;
        Thu,  7 Sep 2023 09:22:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74950C433AD;
        Thu,  7 Sep 2023 16:11:10 +0000 (UTC)
Date:   Thu, 7 Sep 2023 12:11:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [PATCH 0/6] tracing: Fix removing instances while
 reading/writing to their files
Message-ID: <20230907121122.22fc1be9@gandalf.local.home>
In-Reply-To: <CA+G9fYt1dC7=pggtwX2D3jibbLweg+a2LnvYtxfF1nCnqELZSg@mail.gmail.com>
References: <20230907024710.866917011@goodmis.org>
        <CA+G9fYt1dC7=pggtwX2D3jibbLweg+a2LnvYtxfF1nCnqELZSg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 18:54:46 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> This patch set applied on top of Linux next master branch and
> tested selftests ftrace tests [1]. The test run to complete and not
> found any crashes.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thanks Naresh!

-- Steve
