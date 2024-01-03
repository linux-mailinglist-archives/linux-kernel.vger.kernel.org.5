Return-Path: <linux-kernel+bounces-15985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75322823694
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F061C244F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4EE1D54E;
	Wed,  3 Jan 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na6H05pt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3351D53F;
	Wed,  3 Jan 2024 20:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFDEC433C7;
	Wed,  3 Jan 2024 20:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704313861;
	bh=j9zOr4MVPJ7P77EoknA6MqX7RP+EKjOV1BsLDm3LS3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=na6H05ptoQHv2N2mOeK7BhBfX1XY8t6VfEDsymLLtUfB4wKI/gT3RwAseRbNARMEc
	 F3ZFZW5Z0zTDwnaN58ivBLOkZa9mFzk/Yi2gR7bJRZYbQMpLotlLQ5ZkvD0MtmV0hh
	 cjeulpdf3iycI8bHW9SBR3hIJV0KWxZaDeCuaPz0plTjLqK+DycI59pn31GA3Ym7Vb
	 gY2/2OPn1NCpb6WXdfPCgW+8aUxB/ZuXlXOrdz5Z3zO7SlmWfdUt2W42J5w3a93fiQ
	 SWsUzm1jsyddGnIKga/+GlGgq3b+7a69dqGWYh2cncONZbctyT50cT85ifYdE5wB3s
	 97AJulZQXXgCg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Wed,  3 Jan 2024 12:30:59 -0800
Message-Id: <20240103203059.49225-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220202709.98507-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 20 Dec 2023 20:27:09 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> [...]
> >
> > When
> > ----
> > 
> > The meeting will be held every two weeks for 30 minutes.  To cover as many
> > timezones as possible, the meeting will be held once at Monday evening (18:00)
> > PDT, and then at Tuesday morning (09:00) PDT two weeks after the previous one,
> > and repeat.
> 
> Based on the above plan, our next meeting should be scheduled for 2024-01-01
> (Mon) 18:00 PT.  Because it is a holiday for many countries, I will schedule it
> for 2024-01-12 (Tue) 18:00 PT.

My intention was 2024-01-02, but I made a typo.  I also forgot joining the
meeting yesterday, sorry for someone who got confused.  Let's have one instead
on next Monday (2023-01-08) at 18:00 PT.  Hope to see you on the 2024's first
instance of DAMON Beer/Coffee/Chat meeting :)

I also updated the schedule/agendas document:
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ

> 
> Looking forward to meet you in the first meeting of the next year.  Happy
> holidays DAMON community :)
> 
> 
> Thanks,
> SJ
> 
> [...]

