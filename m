Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E157CC40C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjJQNKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjJQNKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:10:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B84F5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:10:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C049CC433C7;
        Tue, 17 Oct 2023 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697548244;
        bh=W4amhWoM6fY/usJOBtMhgFY55JB3YjIRuGcjnILEN1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lhKUtIfmWgoN7eiXW1HtvuSn1hnmVhQ4kURoR8RPK6Ec2smsHceQfiDJGEOWBzFel
         w6w0Xt0MNGlo9DUAHljBecBv3I0/aeGAyv5oqdW/aLlkKGDWvHi7edfRPjYMxVQrRe
         etyQHuCIQud55hjdnbtlWJJeI+16iL8GVOPcKIBNvQMG2051CHZB7OJv33By55kGa0
         qT9+C0zhLrcEFfkEKQCZh6jv+fEw8vP83M/BRjnyKGSWD1x0PnKqUvm94U2Uz6/cI3
         waov3sVDRZUFa0ZVmxcZxEWEMmj7+BeaFBdqZoRqaEr909neyQp8x6pTJkaB7XS9dd
         2IssVCeZXjuMQ==
Date:   Tue, 17 Oct 2023 22:10:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Fixes for 6.6-rc6
Message-Id: <20231017221039.30c56bcbce530583ff31993d@kernel.org>
In-Reply-To: <20231016223931.3dc7ca19@gandalf.local.home>
References: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
        <CAHk-=wi3k8JA93pKh9VjuafNN9Qyrk6eH-tQbWePyRSgXi_3FA@mail.gmail.com>
        <20231016223931.3dc7ca19@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 22:39:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 16 Oct 2023 18:52:02 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, 16 Oct 2023 at 18:39, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Masami Hiramatsu (Google) (2):
> > >       Documentation: probes: Add a new ret_ip callback parameter
> > >       fprobe: Fix to ensure the number of active retprobes is not zero  
> > 
> > No diffstat? Tssk.
> > 
> > 
> 
> He may have accidentally cut it, as I gave him the script that I use to
> send pull requests, and it also includes a full diff. I told him that I
> usually cut out the diff when sending to you. I think he may have done that
> but also cut out the diffstat too.
> 
> Masami,
> 
> Make sure to keep the diffstat on the pull request.

Yeah, sorry about that. I had mistake about the cutting point.

Thank you,

> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
