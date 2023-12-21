Return-Path: <linux-kernel+bounces-8826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC081BCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81093B22CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85093634F7;
	Thu, 21 Dec 2023 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTrt7OOz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327E634E5;
	Thu, 21 Dec 2023 17:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F5AC433C8;
	Thu, 21 Dec 2023 17:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178959;
	bh=T64o/dtQ7k7QygDUHe30OKZ2zq+ngvNvrISkp4YyKtQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UTrt7OOzNo3cbKE4i5QqvfzjePciZenWP480tHgQoFs4pL99PmsDiT4rIXBRK0b/Z
	 4XqRnHccI7Ou4angSRI9f751qQULSmhI8ieQfhT5ZInR0Av0AGNfUiAIVHTBdOXTne
	 I3HG0tdHsYepIs3RAKOrelPS2r4cweJBGgEH3+8+6d0lX0uI7Gh8c3A1/bxRyhOKUu
	 HIcKZoZ/sXq8h9TeJqn7Q6f+U4ecQKshs8igttQaMIWm7/xe6MWDpxdptD8oSu4gyw
	 7ncDXprmqOqoK+Iwg2Rh/2s3JlSJa5pIBM9hbEiznUZKfAfipHp9UC1zLKKaFxhumU
	 hueHlTT74bJbw==
From: Vinod Koul <vkoul@kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Wang Jinchao <wangjinchao@xfusion.com>
Cc: stone.xulei@xfusion.com
In-Reply-To: <202312151407+0800-wangjinchao@xfusion.com>
References: <202312151407+0800-wangjinchao@xfusion.com>
Subject: Re: [PATCH] phy: phy-can-transceiver: insert space after include
Message-Id: <170317895592.712473.1040949125860507698.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:45:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 15 Dec 2023 14:09:00 +0800, Wang Jinchao wrote:
> Maintain Consistent Formatting: Insert Space after #include
> 
> 

Applied, thanks!

[1/1] phy: phy-can-transceiver: insert space after include
      commit: 57f31e911eaa5e682c0a03253f8b4348adee52cb

Best regards,
-- 
~Vinod



