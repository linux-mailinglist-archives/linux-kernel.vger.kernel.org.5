Return-Path: <linux-kernel+bounces-19043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18711826726
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC09F2816DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89540611A;
	Mon,  8 Jan 2024 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYZqdPht"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD673522D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 01:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656CAC433C7;
	Mon,  8 Jan 2024 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704678352;
	bh=xjmnXEKv1lECuwEh6Yk8bttQ20GcHU0SGe1AicjpZEk=;
	h=From:To:Cc:Subject:Date:From;
	b=RYZqdPhtXdOI9JTmdiyBQ44mBTHIo/1bSHGxHRSwfeFWu6zUNLFi/HTDLbVc7ok0J
	 zW8VOBlOyL07swhiY++laQq8Gi2Y3H/bvNGN0H/OfS3Un5SVccJFa5d3th6VqdGXgv
	 43uIONGlAMgBQVHn0zmwfY+RCWFtbfJlHjnR+cQPXKr4jjHfyrQl9wku742ff2ms1N
	 Obgf67GjaJehDeKu9StCG+2CD796wS21jGslcEsP/W1yZTNQU+r0wTaEiErPxOGbMB
	 JLtwJp6gXySKg+PKyYOgzzze1ojSY2u+Sg7fkqae7F07W0+yK7rrkE2rjRlOc34qhS
	 Vk7yCTgpLW5+w==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v6.8
Date: Mon,  8 Jan 2024 02:45:43 +0100
Message-ID: <20240108014543.525447-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

A routine update for clang-format -- we did not have one for quite
a while.

All the commits have been in -next for a month. No conflicts expected.

Please pull for v6.8 -- thanks!

Cheers,
Miguel

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-6.8

for you to fetch changes up to 5a205c6a9f79d14db38006aa2d7c4f4e76b1bfc7:

  clang-format: Update with v6.7-rc4's `for_each` macro list (2023-12-08 23:54:38 +0100)

----------------------------------------------------------------
clang-format changes for v6.8

A routine update of the 'for_each' macro list.

----------------------------------------------------------------
Elliot Berman (1):
      clang-format: Add maple tree's for_each macros

Miguel Ojeda (1):
      clang-format: Update with v6.7-rc4's `for_each` macro list

 .clang-format | 92 +++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 19 deletions(-)

