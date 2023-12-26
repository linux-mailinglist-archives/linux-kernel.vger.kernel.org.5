Return-Path: <linux-kernel+bounces-11472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C5A81E6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3BA1C21DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBCA4D5A0;
	Tue, 26 Dec 2023 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="AG8mafFI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2A4D588;
	Tue, 26 Dec 2023 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail2; t=1703585419; x=1703844619;
	bh=sZFy75hKF/4F9B1nrXJ4XiFKlKCVz0gVueFCburBZb0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AG8mafFII2i/YmQSe1+STW0AD/Lu9rdIdts/qDLplV9huMsfbPyhqtE04uacXDq8P
	 TmvW2eBGegQyRD2SmrtQ6wbINbd2magIeqg6Iz+6VmkkYFvWQuMu7d6fVqqRvFzP3K
	 /R3UgEViDSaYunMfjITW3xNyWYhC3jZUej6RfE2OfKQa5+PSFJZMnVlGg+NoGicOE8
	 /gQyYtS68s/U8zv3s5iAxkl7aZPVbyiTvZP8BWy2+BrqaVM9eVP30snX4D7cI/hZDT
	 l4h7mmhK9TVppTJRf+01zr/r68rhEK9xpGNpXzJ7wZ5JwM9FCEGWB/eXHKNzrk7zgo
	 O8nqeO+3mtbLQ==
Date: Tue, 26 Dec 2023 10:10:13 +0000
To: Markus Elfring <Markus.Elfring@web.de>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 3/3] drm: property: Improve four size determinations
Message-ID: <FB3FfdyqvkWV2j31m-2vOt3ZR6N0aOICuCdgi7Z8bdmOgRg6FYqF-_7tMlbZiEhLHvsRYB124l65-lw0jTYHXKQBFn9xn81MnExufwwFmuA=@emersion.fr>
In-Reply-To: <29dea8dc-5a57-4c07-a857-e2c6a86c5c06@web.de>
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de> <29dea8dc-5a57-4c07-a857-e2c6a86c5c06@web.de>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The whole series is:

Reviewed-by: Simon Ser <contact@emersion.fr>

