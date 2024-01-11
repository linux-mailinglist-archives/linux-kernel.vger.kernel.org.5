Return-Path: <linux-kernel+bounces-23865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A590582B2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347BAB2673F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E018D4F8AE;
	Thu, 11 Jan 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM1vFC08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381CA50241;
	Thu, 11 Jan 2024 16:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009C5C433C7;
	Thu, 11 Jan 2024 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704990491;
	bh=xSjBSkl6SwkjG9eWdKP666ZjCE8KZPMBRi3eU0DZDQc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=eM1vFC08e3I59HWvgI3tK83jl9OCoJC1xLisSe3Yha5d2Xhw0k6RoJiWPVTmNirI2
	 bESwpobj0HZ9+JmtMk93XZe4eLBCyLxYj3/jNeSxLh7m2f9nDPdyXQHYl58Fi0m/CH
	 7yVqHfbdJiC07m90Uq19Pn9Onh4MizNDuM17EpwCeVa/dlaaEsZXMfzjFxgFg8wySN
	 Bk7EPfsZR/hK5Y3xTafPG0GJFZRIyz1WGrpGYjtVm7CQYzLtlrHLe/loHrv6PrieWm
	 T9sXseB0o0tqUtbFleVZStr0dMTaC5z54Y4mP++1ebFlawW/dpXDB14iSKixABCB5i
	 nyBfvRwvEvvCQ==
Message-ID: <89520079-61e5-4cd2-a451-471b1fae088c@kernel.org>
Date: Thu, 11 Jan 2024 17:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [CFP] Real-Time Linux Summit at Embedded Open Source Summit in
 Seattle, April 16-18
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Min Yu <myu@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>
References: <be6876e5-ed73-415b-8f7f-df1a97e9118d@kernel.org>
Content-Language: en-US
In-Reply-To: <be6876e5-ed73-415b-8f7f-df1a97e9118d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Again

This is a gentle reminder of the CFP! This is an excellent chance to participate
in the community, showing results and helping real-time Linux :-)

The CFP closes this weekend!

-- Daniel

On 1/2/24 18:11, Daniel Bristot de Oliveira wrote:
> Hello Real-time Linux community,
> 
> We're excited to announce that there will be a Real-Time Linux Summit as part
> of the umbrella conference of Embedded Open Source Summit in Seattle,
> April 16-18.
> 
> The Real-Time Linux Summit is intended to gather developers and users of
> Linux as a Real-Time Operating System. The main intent is to provide room
> for discussion between developers, tooling experts, and users, in a friendly
> environment.
> 
> The Call for Proposal (CFP) is now open through January 14th.
> 
> We are looking for proposals for topics in the following areas
> 
>  - Best practices for writing Linux drivers to work with real-time
>  - Lessons learned setting up and configuring systems with real-time
>  - Working with real-time Linux in containerized systems
>  - Working with real-time Linux and hypervisors
>  - Lessons learned debugging and analyzing latencies
>  -  Best practices using Linux on safety-critical systems
>  - Future evolution of real-time Linux
> 
> Please consider submitting a talk proposal for consideration. Details on the
> CFP can be found here:
> 
> 	https://events.linuxfoundation.org/embedded-open-source-summit/program/cfp/
> 
> Please help us spread the word about this conference and CFP
> within your network.
> 
> -- Daniel


