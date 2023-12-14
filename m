Return-Path: <linux-kernel+bounces-218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B4813DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A2628370F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68776ABB5;
	Thu, 14 Dec 2023 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3Bo8chF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ECD697B1;
	Thu, 14 Dec 2023 23:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B304C433C9;
	Thu, 14 Dec 2023 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702595137;
	bh=IO5FULWlkV+MW+kAJwWz8tMrzFPuv/l0QUOqEw4vVDo=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=m3Bo8chFM3fUjFZl1LPFjEHaPnTt9ogjRl8OZJCE7u2khbRwC+1isQU4ZBQN8q4Pj
	 g1rHkTul/hiOd48LHtV9Sqq3qSsxA4v4LyAdiKjuBuI7jq9abou4puLGO+jtbka5mV
	 0wGqh9jYYFBH6CwDaZPsZAZAoe6ALjrxjy2pNdNs=
Date: Thu, 14 Dec 2023 18:05:36 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: users@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PSA: final vger mailing list migration: Thu, Dec 14, 11AM PST
 (1900 UTC)
Message-ID: <20231214-snobbish-numbat-of-focus-46ab36@meerkat>
References: <20231212-unselfish-real-myna-67e444@lemur>
 <20231214-unbiased-modest-herring-12b6eb@meerkat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231214-unbiased-modest-herring-12b6eb@meerkat>

On Thu, Dec 14, 2023 at 05:08:44PM -0500, Konstantin Ryabitsev wrote:
> > This Thursday, December 14, at 11AM Pacific (19:00 UTC), we will switch the MX
> > record for vger to point to the new location (subspace.kernel.org), which will
> > complete the mailing list migration from the legacy vger server to the new
> > infrastructure.
> 
> This work is completed, but there will be a brief outage around 3PM PST (23:00
> UTC) to bump the number of CPUs needed for all the increased spam scanning.

All work is complete. If anything isn't looking or working right, please
report this to helpdesk@kernel.org.

Best regards,
-K

