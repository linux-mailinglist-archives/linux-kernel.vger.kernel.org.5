Return-Path: <linux-kernel+bounces-5908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5581915D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C031C240D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A876239AC6;
	Tue, 19 Dec 2023 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFcDFmmM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3939AC9;
	Tue, 19 Dec 2023 20:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0E6C433C7;
	Tue, 19 Dec 2023 20:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703017695;
	bh=mes82iYJ5cE5cpbVnK32DQbxvSbED2LqaND8DMd9EUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFcDFmmMhHkZQXC7e53TDW1eu12kbbJKJgBs2kWYHtiQLoG0iib4ujHeFgJGIB3WW
	 xs7pbt3Ieg+JePju6epTr9KsAhuMuNm/zW5rjx42bD733OMZ/Y6Aj0VidOjEBqq0JY
	 vdXy9hNhbLVA1E0GAzM+VziwISz7x2Dv9d6gUe63TRVNzqrC7Q9CUMT3jIMcBbVifv
	 OcaQUaEwD/h9qtBL3zoslcovMs+niy/scrJ+RwSxa4uqs3iwSkKM/Y23GCtmBhnnaq
	 24uaO3Z+aFYs0+1wbXlrZNGbIIKStXxmFNKcSKm7gb7krrfHqFlgExESEgja/8B6HO
	 tS0ZQvhnO2arg==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] 8650 PLL config updates
Date: Tue, 19 Dec 2023 14:28:10 -0600
Message-ID: <170301768798.369406.4938152862459170879.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231219-topic-8650_clks-v1-0-5672bfa0eb05@linaro.org>
References: <20231219-topic-8650_clks-v1-0-5672bfa0eb05@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Dec 2023 19:55:31 +0100, Konrad Dybcio wrote:
> Some TEST_CTL values were missing, add them.
> 
> 

Applied, thanks!

[1/2] clk: qcom: gpucc-sm8650: Add test_ctl parameters to PLL config
      commit: 3f8d7f490a33625786b427ec925215c4c1f191d1
[2/2] clk: qcom: dispcc-sm8650: Add test_ctl parameters to PLL config
      commit: 757d1ca14f94e4e00777491dcab0b4abee18f9bf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

