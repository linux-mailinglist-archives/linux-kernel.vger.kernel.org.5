Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8427CB87A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjJQCiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjJQCiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:38:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A288E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:37:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27588C433C9;
        Tue, 17 Oct 2023 02:37:56 +0000 (UTC)
Date:   Mon, 16 Oct 2023 22:39:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Fixes for 6.6-rc6
Message-ID: <20231016223931.3dc7ca19@gandalf.local.home>
In-Reply-To: <CAHk-=wi3k8JA93pKh9VjuafNN9Qyrk6eH-tQbWePyRSgXi_3FA@mail.gmail.com>
References: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
        <CAHk-=wi3k8JA93pKh9VjuafNN9Qyrk6eH-tQbWePyRSgXi_3FA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 18:52:02 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 16 Oct 2023 at 18:39, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Masami Hiramatsu (Google) (2):
> >       Documentation: probes: Add a new ret_ip callback parameter
> >       fprobe: Fix to ensure the number of active retprobes is not zero  
> 
> No diffstat? Tssk.
> 
> 

He may have accidentally cut it, as I gave him the script that I use to
send pull requests, and it also includes a full diff. I told him that I
usually cut out the diff when sending to you. I think he may have done that
but also cut out the diffstat too.

Masami,

Make sure to keep the diffstat on the pull request.

Thanks,

-- Steve
