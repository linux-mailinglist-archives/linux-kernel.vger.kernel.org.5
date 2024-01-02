Return-Path: <linux-kernel+bounces-14646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5815822026
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639EF283D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAED154A3;
	Tue,  2 Jan 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhw80pVc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D98156CD;
	Tue,  2 Jan 2024 17:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321F7C433C9;
	Tue,  2 Jan 2024 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704215479;
	bh=fGDoyBWpQ4vyftas01itKV4YkyJNRhIlMm6bq0RArWs=;
	h=Date:From:To:Cc:Subject:From;
	b=Zhw80pVcsrSV9rIuQix/zS3dCk4L3xt99s7fAReA1t8t1UEpuXr9sss1jkhzoVWi3
	 RE+t6FtD1xxskimHWJZBRg4zbAQh2UdsUOHPTUzUejr7CFNp5z1u1UwGHE6GsOKdr5
	 yBY4kJLfCDi7FhJvpTwl2rvyC3utlZ7gSza8XXcXMB6EdsYQzKDG7JSE0ohZZlAlH+
	 gMk6rENRRKze4RL92L9ug56ydLoCK7PvjRLrRU6sv5tz5+G6NYKOMFgOG3FkxsVLkz
	 vXRGXLXIxZhfb1XTLNbhsIkjC7fy4ckn6izJIJ+mR2i8l8lXwE/BVIu8ia0ZJ855RF
	 YlDQC5Rn1aeKw==
Message-ID: <be6876e5-ed73-415b-8f7f-df1a97e9118d@kernel.org>
Date: Tue, 2 Jan 2024 18:11:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Min Yu <myu@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [CFP] Real-Time Linux Summit at Embedded Open Source Summit in
 Seattle, April 16-18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Real-time Linux community,

We're excited to announce that there will be a Real-Time Linux Summit as part
of the umbrella conference of Embedded Open Source Summit in Seattle,
April 16-18.

The Real-Time Linux Summit is intended to gather developers and users of
Linux as a Real-Time Operating System. The main intent is to provide room
for discussion between developers, tooling experts, and users, in a friendly
environment.

The Call for Proposal (CFP) is now open through January 14th.

We are looking for proposals for topics in the following areas

 - Best practices for writing Linux drivers to work with real-time
 - Lessons learned setting up and configuring systems with real-time
 - Working with real-time Linux in containerized systems
 - Working with real-time Linux and hypervisors
 - Lessons learned debugging and analyzing latencies
 -  Best practices using Linux on safety-critical systems
 - Future evolution of real-time Linux

Please consider submitting a talk proposal for consideration. Details on the
CFP can be found here:

	https://events.linuxfoundation.org/embedded-open-source-summit/program/cfp/

Please help us spread the word about this conference and CFP
within your network.

-- Daniel

