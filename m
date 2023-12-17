Return-Path: <linux-kernel+bounces-2713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 866218160E2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272EC1F229FB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E804C3BC;
	Sun, 17 Dec 2023 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiVZMdU5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142284B5C7;
	Sun, 17 Dec 2023 17:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB45C433C7;
	Sun, 17 Dec 2023 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833712;
	bh=6dt+wjTeWK7BJU3XTdKJ9GJNCTBUt7G6O77Gttyi2NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiVZMdU5z8oy4+XD3syIZON7BNEX7o/Sibd3qOElesojL5SjNzg7xdVECxrDydzu7
	 IdaB49n7zu6TVhYo+ODkP7V66a1Lw/lZJc4kVV/ttBPFkbbtsydYeQYqkLrNE9LsXO
	 DjUXFObu1N5OtZgD34WttbBMN85/dig2FuFjBu1gYnkhc6IRU/ChyAI4LuOYhECJ5B
	 uhMQnr+OFia5Ur+d4WiFkHsQNZdG6OIyDhqKAYfmbq/HqWejYmEuW5u0k5TA4c37p8
	 TEndRqBDM+/i/V2N9EwQafG9iGLujryFgqYcS81NNB9TWyCzZIEuAaNcd8g7U91Y9y
	 tmHlxWGbx5E8g==
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: drop stray semicolons
Date: Sun, 17 Dec 2023 11:21:07 -0600
Message-ID: <170283349419.66089.11020326053607618259.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208125827.10363-1-johan+linaro@kernel.org>
References: <20231208125827.10363-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 08 Dec 2023 13:58:27 +0100, Johan Hovold wrote:
> Drop stray semicolons after function definitions to avoid having this be
> reproduced elsewhere.
> 
> 

Applied, thanks!

[1/1] soc: qcom: pmic_glink: drop stray semicolons
      commit: 27117558bbfde4e439230cdb5dda2d12ba801af9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

