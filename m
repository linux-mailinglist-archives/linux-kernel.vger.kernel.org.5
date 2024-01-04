Return-Path: <linux-kernel+bounces-16587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE548240AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F275B2113E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5E821119;
	Thu,  4 Jan 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cTBWwb13"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA22134E;
	Thu,  4 Jan 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A29C2000A;
	Thu,  4 Jan 2024 11:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704367873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNCEmw6CVL0w4M9htlg2iyn94ksGivA6eBFkaY+S0Uw=;
	b=cTBWwb13EuwlZlGoBLhcvUjFlDoqfWBTnSHOY0B5/DxQnnrjYy+ZcjjA+CK9U/5VoFBR2q
	FQ+RaUiYmFclFwr8+0VOD3Ivp3rH/b7XtWdz2Mrv+nXfDdSwA4PavC389J+71vq11YU1tv
	h4y10fpi2Oj8b+3/3ytJvbpg/h+K6d/SUSLkb/IIpp7UbTBHPvSX9FOcNy/duAs96luOjx
	/csx4NUPsG+L2afC9BkJgej76/JnicdTMM+uZFAt/rHsJzwCP8lfVOuUGV8SgaMsE1/jzR
	MLzscMkBDXpp3fQFY8TTZf2AqAGTmqHZvP5Pt7fccirU1qTaa71DfLpWnlwZ7A==
Message-ID: <d8f52066-323d-4622-b6b0-32834a504dfe@bootlin.com>
Date: Thu, 4 Jan 2024 12:31:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
Content-Language: en-US
To: rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com, u-kumar1@ti.com
References: <20231130164953.2043305-1-thomas.richard@bootlin.com>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231130164953.2043305-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 11/30/23 17:49, Thomas Richard wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> This add suspend-to-ram support.

Hello,

Could someone please take a look at this patch ?

Regards,

Thomas


