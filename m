Return-Path: <linux-kernel+bounces-87875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5977386DA3B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9ACBB23D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53852481D5;
	Fri,  1 Mar 2024 03:36:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5F2B9A8;
	Fri,  1 Mar 2024 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264216; cv=none; b=mjO9VZTCYqAzAeXjsV/W+/+U4jHOSQShRBhQOHla4eXIzpXcN/KwdPW6ly+ddgpEfIA6wphEaBRPJ3srmpw36grKm96JlLqkWzlQhiDS6JHWdNZyfdITPlnP39KI737206JMUlM/xEZeFB2Ml3WCVyLQ/oi5uw5Rbg+7DLAKhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264216; c=relaxed/simple;
	bh=8K4PjEW9V/J1OjcEgLD+HrIHOLUaJZeHw10F7RJliWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvZRNMqsOL8XjTI0/Q+UwOBWXfTrEEeIiiQSs1KcViQ9DJWUobsCbWVv/C0Jo+vP4DvixtIDe3dTeToMDMz9NAUefGFvQe5VcTGGL7HY7OzF5vQT392FUDnvj0Kgk0bW5d6bTFAes05jcFBDW2W0zkBrFwcsPKwSJAyYLIVpLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD5FC433F1;
	Fri,  1 Mar 2024 03:36:55 +0000 (UTC)
Date: Thu, 29 Feb 2024 22:39:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/7] tracing: Remove redundant #else block for BTF
 args from README
Message-ID: <20240229223902.4b0ae423@gandalf.local.home>
In-Reply-To: <170891991338.609861.6605068606690943019.stgit@devnote2>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<170891991338.609861.6605068606690943019.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 12:58:33 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Remove redundant #else block for BTF args from README message.
> This is a cleanup, so no change on the message.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

