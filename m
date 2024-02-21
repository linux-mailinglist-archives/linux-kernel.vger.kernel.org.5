Return-Path: <linux-kernel+bounces-75290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F322185E5E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA9E284D10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14CA127B53;
	Wed, 21 Feb 2024 18:24:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA78528C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539895; cv=none; b=BM+hxdQGeHARHU58s9Hc8VgByRnWYbt8tgNzBf4EZpXDaKgltqUoI648FP9BjhmwPjqMfomzy8C2TmexlOai+hOnngb/dRu6DxlAwhPC5UMs6BVE0eBhDY4AVyifcnGVfaxcGDpAfyeS1e+eQ5acr73yX4//gRpgjxsw1kapqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539895; c=relaxed/simple;
	bh=RWCWXtYM4cIpVTDcprNPaSGxqNSL+C9bOxCzGwFTpKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5sG9ATsrVAKgcVQd2tESwqJRJFeT5XHnzezHyb4r1F5SYDN/CX18n1vb5KKFngEntrYGtbSY7HvH7CFKyJubKCm8EwX/7UfeEdEX8OvKtY3rWYSB+xfkiQtfi/ctiil1gVRJ6dQL2lVOVXuNXUIutckEsiPfWTuz1bqke2B0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C85C43390;
	Wed, 21 Feb 2024 18:24:53 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/sysreg: Update ID_DFR0_EL1 register fields
Date: Wed, 21 Feb 2024 18:24:51 +0000
Message-Id: <170853986942.1224167.4579848259208066765.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220025343.3093955-1-anshuman.khandual@arm.com>
References: <20240220025343.3093955-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 08:23:43 +0530, Anshuman Khandual wrote:
> This updates ID_DFR0_EL1.PerfMon and ID_DFR0_EL1.CopDbg register fields as
> per the definitions based on DDI0601 2023-12.
> 
> 

Applied to arm64 (for-next/sysreg), thanks!

[1/1] arm64/sysreg: Update ID_DFR0_EL1 register fields
      https://git.kernel.org/arm64/c/7accfaad89d7

-- 
Catalin


