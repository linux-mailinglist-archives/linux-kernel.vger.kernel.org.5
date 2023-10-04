Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7807B81D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjJDOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbjJDOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:10:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73314AD;
        Wed,  4 Oct 2023 07:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1675C433C8;
        Wed,  4 Oct 2023 14:10:22 +0000 (UTC)
Date:   Wed, 4 Oct 2023 10:11:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH] visl: use canonical ftrace path
Message-ID: <20231004101129.0d290cc5@gandalf.local.home>
In-Reply-To: <691b9545-0caa-4b8f-a745-13ba811c94dc@xs4all.nl>
References: <20230829204600.3210276-2-zwisler@kernel.org>
        <20231003174129.11c79c18@gandalf.local.home>
        <c7e21ecf-9554-425d-a8c1-90f890de6bb4@xs4all.nl>
        <20231004095720.5727254a@gandalf.local.home>
        <691b9545-0caa-4b8f-a745-13ba811c94dc@xs4all.nl>
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

On Wed, 4 Oct 2023 16:00:34 +0200
Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:

> > The original patch did have linux-media@vger.kernel.org Cc'd. Was it dropped?  
> 
> You are correct, it was sitting in patchwork, I somehow missed it.
> 
> It's now delegated to me, so it is in my pipeline.

Thanks a lot! I appreciate it.

-- Steve
