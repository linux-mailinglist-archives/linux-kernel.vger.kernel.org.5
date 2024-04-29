Return-Path: <linux-kernel+bounces-161920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA678B534F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA328189E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476A1803A;
	Mon, 29 Apr 2024 08:39:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A813AEE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379988; cv=none; b=EHAiAlO9Q+VMPt7BgfqEZew/ebE5WFVDGytQIZ7YAD7aIqRun1pOdgEe33BAmEuTPxc5w3uMay7eey8fi/dq48mULAjfG87VdC9P/X1dzSdJP3VgTSPpiaD+r/EVvak70rV03t16tFZe9VJX1QAI+CdWe6vdM/q5sR8erUK+Grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379988; c=relaxed/simple;
	bh=GZD5rcq8uN4dOjNDWnvRX0H7kvVXorQm2ww5MINtELc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqpiECE4NTHKQpODzcC0MTVpSC/Jb/2kB7Dr2jaGqnuKwEcxV2nhHZpZTOTJ8Jf8tX0E/UX0kXcdTyAWyAJdfFH0ykOI9kq1UtKg7LNhv2yLj9zo57PCmvNMA7kcqA1UedjlLFt0zr4rZm3WtEa0auekljccqt6xmvnoxMsvBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8264A2F4;
	Mon, 29 Apr 2024 01:40:10 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49EAA3F73F;
	Mon, 29 Apr 2024 01:39:42 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: mike.leach@linaro.org,
	james.clark@arm.com,
	Remington Brasga <rbrasga@uci.edu>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org
Subject: Re: [PATCH] Docs/ABI/testing/sysfs-bus-coresight-devices: typos/spelling
Date: Mon, 29 Apr 2024 09:39:33 +0100
Message-Id: <171437996270.4735.16215538732856375378.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428011401.1080-1-rbrasga@uci.edu>
References: <20240428011401.1080-1-rbrasga@uci.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 28 Apr 2024 01:14:01 +0000, Remington Brasga wrote:
> Fix spelling and gramatical errors
> 
> 

Applied, thanks!

[1/1] Docs/ABI/testing/sysfs-bus-coresight-devices: typos/spelling
      commit: 2d7e8a64a1e79f76b9d1165db0b92190d4663848

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

