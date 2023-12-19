Return-Path: <linux-kernel+bounces-5880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E988190E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A0028218F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F4F3FB12;
	Tue, 19 Dec 2023 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJjRLgiZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC13EA77;
	Tue, 19 Dec 2023 19:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23D2C433C8;
	Tue, 19 Dec 2023 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014430;
	bh=TAPnHhI6IMyE1QDxyjz1LJ4Z2C+hHBuEkb8XQ+VPyWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJjRLgiZiSLvi9bG/CtxW8vvmkMQMsqJTCSrQpwzUo3ZwqHpDYGm66bwVQEZ6CkpS
	 UbPUfZ7IqMlg6R0IIHUm3pd7SuSQec2ufCy0mpRrYcM9sWSqEctsOOepCZa6Qksnqr
	 oafRzxzc8xsZ6V/ZCLRG4uFwY0ngo+4FjW2runEgRER6b9kFx+XaYgjDsLABjbMzsx
	 qfd/gAbGSrlFPc5/nGZkwNN/xNazKudS43DDmVsGByyZnzyLM1adbLg//C1JyaFTSU
	 qpK0w+QIoh0ypu0h1sEn/yjcq29pQL1CdeD0YYQqnQfdtxTZFR8Y562Gy2zmgOv9mM
	 OAIHqV1rveDmA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: enable GPU clock controller for SM8[45]50
Date: Tue, 19 Dec 2023 13:33:35 -0600
Message-ID: <170301441255.365364.1342268714697258363.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231218-topic-sm8x50-upstream-gpucc-defconfig-v2-1-e5892470a10b@linaro.org>
References: <20231218-topic-sm8x50-upstream-gpucc-defconfig-v2-1-e5892470a10b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Dec 2023 11:30:23 +0100, Neil Armstrong wrote:
> Enable GPU Clock Controller for SM8450 and SM8550 to allow using
> Adreno GPU on these SoCs.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable GPU clock controller for SM8[45]50
      commit: e45167b2d3fd98b6553c30360f9d9bcbd737ce6c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

