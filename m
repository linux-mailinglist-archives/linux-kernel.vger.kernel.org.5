Return-Path: <linux-kernel+bounces-13203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41519820118
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96B0B20E74
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111E112B9D;
	Fri, 29 Dec 2023 18:51:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CE12B8E;
	Fri, 29 Dec 2023 18:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5AFC433C7;
	Fri, 29 Dec 2023 18:51:45 +0000 (UTC)
Date: Fri, 29 Dec 2023 13:52:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [RFC][PATCH 0/2] ring-buffer: Allow user space memorry mapping
Message-ID: <20231229135236.337c482b@gandalf.local.home>
In-Reply-To: <20231229184050.465784896@goodmis.org>
References: <20231229184050.465784896@goodmis.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Dec 2023 13:40:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm sending this to a wider audience, as I want to hear more
> feedback on this before I accept it.
>

I forgot to mention that this can be applied on top of:


   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  for-next

-- Steve

