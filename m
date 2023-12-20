Return-Path: <linux-kernel+bounces-7412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB71781A797
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE4F1F233B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3148CC0;
	Wed, 20 Dec 2023 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTiLWw4x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CAC4879E;
	Wed, 20 Dec 2023 20:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0BBC433C8;
	Wed, 20 Dec 2023 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703104031;
	bh=YaZ+fgvfDDyr7sF8ra/fxCAyrXvKa41hDBT0c35o9LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTiLWw4xH53XoGOtQSoCwg1UL3biLaSbJ5VfHLE/gX0ApH14fgJSeg4btIrXlOP0A
	 6JQiPJ+UfySDY2j/7DxgY1UrKkpMoUG7l6MtpFwzRnESAc4tbfWbpvl1eGj3K2ok6u
	 HaRirdBT5tCAYrNcya/12ressHC4Zftj4SqVVjR7z/fJGMoi/aJnCok1QbK1HD66Dg
	 ixnD/uVABLkKlGiZ8LQUU7KEBlH8PlfhviYicEjsYDiprld5yxtkFPGPdOoMXdSfbn
	 rFpnXqb2+gFzePrS0m1eEh5ZR/GXAZjmfidYw/uxCraEedtPA62HNxK/Dkv3Gf3TPf
	 RMK8QESqUNqzA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Wed, 20 Dec 2023 20:27:09 +0000
Message-Id: <20231220202709.98507-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
[...]
>
> When
> ----
> 
> The meeting will be held every two weeks for 30 minutes.  To cover as many
> timezones as possible, the meeting will be held once at Monday evening (18:00)
> PDT, and then at Tuesday morning (09:00) PDT two weeks after the previous one,
> and repeat.

Based on the above plan, our next meeting should be scheduled for 2024-01-01
(Mon) 18:00 PT.  Because it is a holiday for many countries, I will schedule it
for 2024-01-12 (Tue) 18:00 PT.

Looking forward to meet you in the first meeting of the next year.  Happy
holidays DAMON community :)


Thanks,
SJ

[...]

