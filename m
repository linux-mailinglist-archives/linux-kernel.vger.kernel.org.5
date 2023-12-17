Return-Path: <linux-kernel+bounces-2709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757EC8160D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2C32835D4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED82649F97;
	Sun, 17 Dec 2023 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCNwp52h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41649F6D;
	Sun, 17 Dec 2023 17:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB35C433C8;
	Sun, 17 Dec 2023 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833708;
	bh=E7Q5MUPddMCiXFIaLe3HbuVVDPSkMKk2xxK1c6hW8lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCNwp52hx+gIBpbSq4i8xNLUnDwkUNMgouHXrpyVb9S1Mv2d+rNfUG+xZeP983CCT
	 KQpZh7Dvp6xkP6fxLBdEB2Fnp1Zyfe/dcFzJaMzlcmDhYUqK/qEiTbcnI20V3p9Og9
	 wdhd02mhknfaXDupAChZB+aShYN8D0hCTlY+5t2cT+uD/P0T04qO2vjXvG51uiqKfo
	 0ov8NKaOZEAkpbQlfXvGrHxj7rBSFNZqLQKiuj8rOU4r8E2fSHq7YfNysk4jGgbHRJ
	 mPT94A+JeBom2nGVicsF4/P9lN/J++dqUhofCg+MI2xkDy124HgMhgreoc32cCHVI1
	 YwZXkgu+/bZ+Q==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org,
	konrad.dybcio@linaro.org,
	Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: soc: qcom: fixed a typo
Date: Sun, 17 Dec 2023 11:21:03 -0600
Message-ID: <170283349433.66089.12804921951390196327.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215070707.560350-1-ghanshyam1898@gmail.com>
References: <20231215070707.560350-1-ghanshyam1898@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Dec 2023 12:37:07 +0530, Ghanshyam Agrawal wrote:
> Fixed one typo.
> 
> 

Applied, thanks!

[1/1] drivers: soc: qcom: fixed a typo
      commit: ff5fed86be58a8351938bb4c828f77329cde4cbd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

