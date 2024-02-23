Return-Path: <linux-kernel+bounces-77719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C046A86096F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728631F25859
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833BDD51B;
	Fri, 23 Feb 2024 03:34:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8F3BE7D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659264; cv=none; b=PRXcbHkr62UUEEeo46Pis4KRqyF7kn5J+BC+7k3QkCwwijjGXVPjBXQ8b8ug+8MDZLEv/7e0FGG5Ke8wCFB0sddRPOfaavIhAoON0NAivgnVzlhrMOUUIIC06vIrmIA9HjpM3N01gKiizjMZIO4CCwOpMhMtOUQzXE8QXiV6i1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659264; c=relaxed/simple;
	bh=WGvGtpIelB3akUnUQmhtINglYa7aCFpsvNYm7YEmSAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH5B1YA1K+X8+RZFp+lK1YdhwxQeuhqq8+A1IXDvRG0bY0Qv7Zc4r+/KtAdhvMHGF5qhVN1qoefAvSAgDmZIUozp3QrdakrRcj7fLcjpA6xAbA29yrwuMmKIpzksm1cZHYX+XX9rd8/OnvhOZz0XYC2eyyOeKhviiWp+W9yjEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B1115DB;
	Thu, 22 Feb 2024 19:34:59 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CE823F766;
	Thu, 22 Feb 2024 19:34:20 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	cristian.marussi@arm.com,
	james.quinlan@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update SCMI entry with HWMON driver
Date: Fri, 23 Feb 2024 03:34:13 +0000
Message-ID: <170865920980.117930.1362332661461808684.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222193027.920006-1-florian.fainelli@broadcom.com>
References: <20240222193027.920006-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 11:30:27 -0800, Florian Fainelli wrote:
> scmi-hwmon.c is tightly coupled with the SCMI subsystem, fold it under
> the SCMI subsystem MAINTAINERS umbrella.
>
>

Applied to sudeep.holla/linux (for-linux-next), thanks!

[1/1] MAINTAINERS: Update SCMI entry with HWMON driver
      https://git.kernel.org/sudeep.holla/c/c2f0961a45c4
--
Regards,
Sudeep


