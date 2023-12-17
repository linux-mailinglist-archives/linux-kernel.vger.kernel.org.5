Return-Path: <linux-kernel+bounces-2703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A528160BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E728282478
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C146B97;
	Sun, 17 Dec 2023 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1tCdlFz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EDA46550;
	Sun, 17 Dec 2023 17:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB346C433B6;
	Sun, 17 Dec 2023 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833697;
	bh=o3D2pm7NIT6Ja2zYN9r6wogJ5yLiX3ItoJuQENH/vBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1tCdlFzUAeyY9U4DpW0bmxbDHD1V3MWwpQVZxEaN55Brj3MeV9n9OCiRLxf93El2
	 6q3RZK820rEFU4bDfeIXGvKbQ3Em1lDNd1yn98JVNeZvnkX57RjDV2rvZoJQOmjVLE
	 IWWOIl4lJ+/kBFpgsejY7SE4kJOFZ9yq3+18CGZCj2SVywfMIvmuNHv38NxvnD3IZ4
	 8h34cOipHtrPo+xXkXKdYHwUcGh47wW2D1RGgOq+6WAx5n4zHpiqlRJEhLfplsRtyP
	 HtxaN9774/WM/dyPg5Rwjwl+zOXWXlwhT/kn1MAHjlm5U06xR4XE4F8PtuGsgKz2XI
	 4ZSEEbFz7v5eQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] soc: qcom: llcc: Add missing description for members in slice config
Date: Sun, 17 Dec 2023 11:20:54 -0600
Message-ID: <170283349414.66089.2074359282863172872.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205-llcc-fix-slice-config-warnings-v1-1-d6331d601dd3@linaro.org>
References: <20231205-llcc-fix-slice-config-warnings-v1-1-d6331d601dd3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Dec 2023 10:10:29 +0200, Abel Vesa wrote:
> Fix all warnings thrown due to missing description for some of the
> members in llcc_slice_config.
> 
> 

Applied, thanks!

[1/1] soc: qcom: llcc: Add missing description for members in slice config
      commit: fd4b634f9b9b3dc059cf1c0ff243711bb245c004

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

