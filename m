Return-Path: <linux-kernel+bounces-5036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE48185B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9ABF281547
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC714F91;
	Tue, 19 Dec 2023 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbhE/D2j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854E14F67;
	Tue, 19 Dec 2023 10:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A142C433C8;
	Tue, 19 Dec 2023 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983202;
	bh=otAQ38rB3LXDgplWgIxY+zsvLHAmBokvqcYg5UKjARE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=rbhE/D2jR3UKWQeAxdjVuJIi/NUYeuh04EyBAD9uUCXzCbyZo72gr3CuFT1rcWKIH
	 By+dSh5r2MSvcawDaKxggQPo0hlGHoPnBDFGU4yTNz7uE0CPIqI5Wyr57EpUEPb/KD
	 R3YCGherpG+9FmFbr8sbYRtwAUTqSdKe4QF2LH8mueBBeRfLDZxBWXXWjJ2xls0eVO
	 TvuAhnGSEq9bO5f4ffFV5RqybdMtoWplrYg8QcVSsxImpHlt0WirPf6hXxXeQYi9Pe
	 fPOD2j70CxjdxaxXBe169GGGx85qsLwfzrVdaLbph8N9sWHlJc7M+5dZTiZxPUgjU6
	 PXQeQKB0Qz8PQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,  Lukas Bulwahn
 <lukas.bulwahn@gmail.com>,  Arend van Spriel <aspriel@gmail.com>,  Franky
 Lin <franky.lin@broadcom.com>,  Hante Meuleman
 <hante.meuleman@broadcom.com>,  linux-wireless@vger.kernel.org,
  brcm80211-dev-list.pdl@broadcom.com,  kernel-janitors@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: MAINTAINERS: wifi: brcm80211: remove non-existing
 SHA-cyfmac-dev-list@infineon.com
References: <20231218121105.23882-1-lukas.bulwahn@gmail.com>
	<170295913267.640718.8284035097366475252.kvalo@kernel.org>
	<18c814f4890.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<29c3122ca8e4d72c07942d09dca7a0fbd0138024.camel@sipsolutions.net>
Date: Tue, 19 Dec 2023 12:53:18 +0200
In-Reply-To: <29c3122ca8e4d72c07942d09dca7a0fbd0138024.camel@sipsolutions.net>
	(Johannes Berg's message of "Tue, 19 Dec 2023 11:41:18 +0100")
Message-ID: <8734vysbtt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2023-12-19 at 10:01 +0100, Arend Van Spriel wrote:
>> > 
>> > > When sending an email to SHA-cyfmac-dev-list@infineon.com, the server
>> > > responds '550 #5.1.0 Address rejected.'
>> 
>> Is the claim here true? In another thread I replied all including this list 
>> and I am not getting a bounce message.
>
> I also got the bounce, FWIW. And Lukas is using gmail ... if you're not
> accepting mail from gmail I'm not sure you get to call it "email" in the
> 21st century, for (better or) worse...

And is Infineon even contributing anything to upstream? At least I don't
have recollection any recent activity, though happy to be proven wrong.
We shouldn't have dormant information in MAINTAINERS file.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

