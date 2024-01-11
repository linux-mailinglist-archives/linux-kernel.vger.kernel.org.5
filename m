Return-Path: <linux-kernel+bounces-23400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0E82AC50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA41F256E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74188154B7;
	Thu, 11 Jan 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKtcc3BL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9AF154A7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7646FC433F1;
	Thu, 11 Jan 2024 10:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704969783;
	bh=PevsBe+isYTBwcCRYntoszIuRMNpbhXxqqfJYgXNRVw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=kKtcc3BLEDXGH1Jo/v7qrgoGkSoCwCG2tg7ClWbzkUUu/H4gqNXnl6IcysBTuIoXP
	 HN0SwHPeFJO1hUbXRoLJFKAU1GZSa1L8U735gsx6hq80h5pLFaypNyhLf0KNxmLsS0
	 WSagMHvTBNDmysz5rMcs5ZCiMHnPW4smuKeB17q1c/hZndiVvjCoXF8I7Q90gywhNm
	 iSSpmFfkfM2XoWDQQPCbw/cD3fQOwEHtm84dcv+4zpd9tzhuqv6EpNNJa+Z9Iq6OZ3
	 jRrxy2PRY0dCWsJgFm1L17R4+9/rrCbbRH8QDsbNsvHfDqC7pTr6NZ6H65cJ1E7PHl
	 NGzqXuPi2e7LQ==
From: Lee Jones <lee@kernel.org>
To: Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20231229145059.6138-1-ilpo.jarvinen@linux.intel.com>
References: <20231229145059.6138-1-ilpo.jarvinen@linux.intel.com>
Subject: Re: (subset) [PATCH 1/1] mfd: lpc_ich: Use ALIGN_DOWN()
Message-Id: <170496978217.1673729.8134810402163397758.b4-ty@kernel.org>
Date: Thu, 11 Jan 2024 10:43:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Fri, 29 Dec 2023 16:50:59 +0200, Ilpo Järvinen wrote:
> Instead of open coding, use ALIGN_DOWN() for alignment.
> 
> 

Applied, thanks!

[1/1] mfd: lpc_ich: Use ALIGN_DOWN()
      commit: 39852f0bbf9f29f2e4946d20c764ed7eb85d4a24

--
Lee Jones [李琼斯]


