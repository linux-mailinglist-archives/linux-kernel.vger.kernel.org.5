Return-Path: <linux-kernel+bounces-2724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389CE816104
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1AB1C2202D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683256381;
	Sun, 17 Dec 2023 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7k+0r7y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA051C48;
	Sun, 17 Dec 2023 17:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CF2C43397;
	Sun, 17 Dec 2023 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833725;
	bh=MQs6fwnnttLvFhtgmQ9j3+0BPphg+EW0yMCBthqtJJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7k+0r7y2Hwx8CCJ3dqPcVzYGZT+b7y2eK2esB/j1kGsgCLs55KbztqIuz1+HRTRP
	 XaU8M27zCaXjSAFba1+mW1ItNhHgpzG2dT1T6Ou7PFJifeE7aaaDcq6gDLVtn1MCQD
	 7K+ern5tHLOpFU988aKmbJH+D+H1PsSccWVOHEz1+FVOqYPtbO3FaoQLvvmvNeidaZ
	 GOIoq9Ia1vw4u0XoV2ojjMGKEk0pknB6E7PFw6JFXrVx2F8VmU/41AuactwkwjaPSS
	 SAFQSiiAUwE2MF+eIUZla+APHNRTdovO9dYiRUpqW+vgDx1VxvKkMkGhGP3TaYm7G9
	 O5NJheCuU4GcQ==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: qcom: Fix up htc-memul compatible
Date: Sun, 17 Dec 2023 11:21:18 -0600
Message-ID: <170283349424.66089.2317743549894432446.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211-htc-memul-fixup-v1-1-c0aeab5aaf44@z3ntu.xyz>
References: <20231211-htc-memul-fixup-v1-1-c0aeab5aaf44@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Dec 2023 20:28:07 +0100, Luca Weiss wrote:
> While applying the original patch, some things got messed up and it
> didn't apply to the correct section. Move the compatible to the correct
> location to fix that.
> 
> 

Applied, thanks!

[1/1] dt-bindings: arm: qcom: Fix up htc-memul compatible
      commit: 82d8c1e49c1be63c6927842a7c3042d4d53fe8b2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

