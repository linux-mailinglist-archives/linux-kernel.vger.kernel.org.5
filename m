Return-Path: <linux-kernel+bounces-77444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C5860566
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFF428641E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE25137924;
	Thu, 22 Feb 2024 22:05:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8812D20E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639555; cv=none; b=Kkrm4fl8yQbchfAOvkW9yGmZXkBIf6bveoUk+Y4lViBi99fxZ9bPtD8LI27aIFgzwHGEd0FJrPwjbW0SxuJUTEcs802eOO57MQE/mY2hhD0zIbypCjAaw9Tb+xdSrVOc4dYHc44q2YI39VD8ZQTPZgTr/26xFwfn3kFRCdiVb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639555; c=relaxed/simple;
	bh=JhRplTuUNMSmK348Jo4Y667OPS72zBZ8QHse7XhYbrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOzsuvskDt25nzCMQuTN9aGps/IfiDNt6xUtCx8pkdoDhHTH8U3A9bjwIxTdHK0OhhTYKqDZn/ZNGrt3E3Z8Z4PjUWMoDvLu/Y5kykHG7e4aMR66xzHz1Nw9+w1AeSmpx0vsHy90v7D/X15W/tWFIG4KfoJw8nFbu7Vvg5H9g4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FFAC433F1;
	Thu, 22 Feb 2024 22:05:53 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] arm64: gitignore: ignore relacheck
Date: Thu, 22 Feb 2024 22:05:51 +0000
Message-Id: <170863954734.1625463.11560852190517987488.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222210441.33142-1-brgl@bgdev.pl>
References: <20240222210441.33142-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 22:04:41 +0100, Bartosz Golaszewski wrote:
> Add the generated executable for relacheck to the list of ignored files.
> 
> 

Applied to arm64 (for-next/stage1-lpa2), thanks!

[1/1] arm64: gitignore: ignore relacheck
      https://git.kernel.org/arm64/c/275826914925

-- 
Catalin


