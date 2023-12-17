Return-Path: <linux-kernel+bounces-2615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643F815F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17191B21A9D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106D44C94;
	Sun, 17 Dec 2023 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PokS8gVM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A744C91
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE466C433C7;
	Sun, 17 Dec 2023 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702820483;
	bh=xw9CQJtCVy3MNipdzdx/1BCVW5eFFNAIZrs5yO8OMW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PokS8gVMXlnnPRTBnnuXuPF7at2vOuUWUsyiOk4FuBABsfhRI2EnDAiFgM3hed5BG
	 lrxf9vnJuBIpTy200WAogUI9BbmH8BElD70+BZ0w78iYHkmCJlG11xzI1qfH+5Z5sP
	 z5Fybg69Led/aHj5fRTQenYoEMe3LJHG8xXPem4fq8pbipzqtPE1HjgAljeuw1Q37t
	 5uo9T2yv87P1SLeShAqA8vVBVyW0exYAuPczd2INdkawwdZPTzJ9+8LM397fu4Wot7
	 6kmGSJ89bcWUADcKgHoctDAjXAh2rBJgdEVbJRRMDuJ5PKexn52QK9VIjyg0iqO1O9
	 y5i6g6lDFz1HQ==
From: Will Deacon <will@kernel.org>
To: Wang Jinchao <wangjinchao@xfusion.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	stone.xulei@xfusion.com
Subject: Re: [PATCH] arm64: memory: remove duplicated include
Date: Sun, 17 Dec 2023 13:41:08 +0000
Message-Id: <170281487405.360120.10807980277347263499.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <202312151439+0800-wangjinchao@xfusion.com>
References: <202312151439+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Dec 2023 14:40:08 +0800, Wang Jinchao wrote:
> remove duplicated include
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: memory: remove duplicated include
      https://git.kernel.org/arm64/c/5cc5ed7a668d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

