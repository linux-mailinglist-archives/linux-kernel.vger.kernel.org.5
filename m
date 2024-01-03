Return-Path: <linux-kernel+bounces-16020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D9E823713
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDAA1F25328
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163DB1D69F;
	Wed,  3 Jan 2024 21:24:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F61DA23;
	Wed,  3 Jan 2024 21:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C96FC433C8;
	Wed,  3 Jan 2024 21:24:32 +0000 (UTC)
Date: Wed, 3 Jan 2024 16:25:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer/Documentation: Add documentation on
 buffer_percent file
Message-ID: <20240103162535.6de92d55@gandalf.local.home>
In-Reply-To: <87h6ju86fh.fsf@meer.lwn.net>
References: <20231226130149.4685c838@gandalf.local.home>
	<87h6ju86fh.fsf@meer.lwn.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jan 2024 14:15:30 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > When the buffer_percent file was added to the kernel, the documentation
> > should have been updated to document what that file does.
> >
> > Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v1: https://lore.kernel.org/all/20231226123525.71a6d0fb@gandalf.local.home/
> >
> > - Fixed some grammar issues.
> >
> >  Documentation/trace/ftrace.rst | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)  
> 
> Are you planning on shipping this one upstream, or would you like me to
> pick it up?

I was hoping you can take it, but please take v3.

  https://lore.kernel.org/all/20231229122402.537eb252@gandalf.local.home/

Thanks!

-- Steve

