Return-Path: <linux-kernel+bounces-2731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E2816117
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B4CB22AC0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099959534;
	Sun, 17 Dec 2023 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clvh2emy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5F58AC9;
	Sun, 17 Dec 2023 17:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0675CC433CA;
	Sun, 17 Dec 2023 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833733;
	bh=tPZ71ehRG6tJ4CvLgwiLNVLqGfDiQ4aDAvtszWWXqjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clvh2emy3Pt9dn2uwqKkvpaqEKwkaQ3RPTNE1yRc/ClDj3mfmSWYWRzGO2RFqsVbx
	 13UEZu4jbKY+VPKOXilYL+lT49LyJ0KN038j1eEBPsq8lER59NNPubC8LyYtUTatu6
	 W7N7i4KA301CuFswNoj/HRbL6dqek7qaHDoVRXJbuPX9u7eklDis1sfqTjazt8Q/ou
	 rBheHfiSvAqX8f8gSRM236bug6W2ws3MYpotCCHwXOOf+HwajLaGbHcvuVWkeI3NGX
	 plbHeEEI/WW/0WvTNLqLmdtLq+9CZQ5LkRNV3Ch2p/IDLJ7gPCDzfw1s0G2uPfLQMC
	 OJbTeyBAzeIAA==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Naman Jain <quic_namajain@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH] soc: qcom: socinfo: Add few DSPs to get their image details
Date: Sun, 17 Dec 2023 11:21:25 -0600
Message-ID: <170283349415.66089.1894701937774333207.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205101018.6079-1-quic_namajain@quicinc.com>
References: <20231205101018.6079-1-quic_namajain@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Dec 2023 15:40:18 +0530, Naman Jain wrote:
> Add support to get image details from SMEM for DSPs like
> DSPS (Sensors DSP), CDSP (Compute DSP), GPDSP (General purpose DSP)
> while also supporting this for more than one DSP of certain types.
> 
> 

Applied, thanks!

[1/1] soc: qcom: socinfo: Add few DSPs to get their image details
      commit: cea0585caf068a068bddf2e985ad781c926e3cea

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

