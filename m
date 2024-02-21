Return-Path: <linux-kernel+bounces-75288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36B85E5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6696E28564F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06DA126F1E;
	Wed, 21 Feb 2024 18:24:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B88563B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539878; cv=none; b=RkPy1cxniRtG74bMSpmhJAw/Rl9k2mXNCjwV/HLX21Aq56fMRSXjjgiWr9GKEWjBFlfTyyjwFs0dkbrICrEi9YlBoBx0Q3r0ggERQ+qbU0UFiviB8M+p1DGORalHdoVCX3A960fcsdV2Cgyvaqz1qz4aMM0D08uqGbhiMuskCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539878; c=relaxed/simple;
	bh=F8H1PU+t5ilAFRJhwzx62oKzGmROfhG0ABOqn9QOr7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMVC4ufCbIrhwIS1PxX01A1e9neL4crtCMh+sD5EBO1tG97QeJ+5S/QyRABkN6P6PB4h/Q++u4WJliC/jR0Xiz9Qe/hWppeGfFbQOSupuAzGnyjZFRJ+f5ijxO3Xrm6H+6q0M+ESBOhM6BTTxOOANw9y7yJbGqpZAMvcnYw/92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE1DC433F1;
	Wed, 21 Feb 2024 18:24:36 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
Date: Wed, 21 Feb 2024 18:24:34 +0000
Message-Id: <170853986942.1224167.1095743361724562701.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220023203.3091229-1-anshuman.khandual@arm.com>
References: <20240220023203.3091229-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 08:02:03 +0530, Anshuman Khandual wrote:
> This adds register fields for ID_AA64DFR1_EL1 as per the definitions based
> on DDI0601 2023-12.
> 
> 

Applied to arm64 (for-next/sysreg), thanks!

[1/1] arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
      https://git.kernel.org/arm64/c/fdd867fe9b32

-- 
Catalin


