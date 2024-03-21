Return-Path: <linux-kernel+bounces-110209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C69885B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA3C1C2203C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD488624F;
	Thu, 21 Mar 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lloGY6fs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49441775;
	Thu, 21 Mar 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034377; cv=none; b=j4JBE6ZaedleOI36uC3n+TrS99IJ2ZlK5KTXDwXay/xpCe8E1+Q6E9uyqkEl7gKo25DplxhFO/wtzc0TcUFi/jyQSRUihOLNtXia2eWXdD0f1u+0CAKXe8XqKhWevQ+2quklnbhaspYqs4LCGgdreJepYxvPHyn9VtpTpApIp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034377; c=relaxed/simple;
	bh=JagbLAWs5oV14b4pWzc+FAMEcZLOG8pm8iM+Ow8+Yi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n93ii+9krFgWKxINA1zNf9w0ehbMXLTIlLLN2cedJ9mal3JL4to5sPdHq1y3b54kLA/dNh7kF7RSsH+SnhYW1RgM4k89R08WAAjx3sFaoH7xIt+CSXgyulzZKiwrock5NKaNQj/lkjMZuQ5W7bCd5A1YDmAFsqFRSnsrl51aUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lloGY6fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A73DC433F1;
	Thu, 21 Mar 2024 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711034377;
	bh=JagbLAWs5oV14b4pWzc+FAMEcZLOG8pm8iM+Ow8+Yi8=;
	h=From:Date:Subject:To:Cc:From;
	b=lloGY6fskoz0QoaV3F3FSzytf1O/aBgLGQ22LWzI4+uWeyq3k28tqrFHRJdrjYzUh
	 Vgp9G1uZJFZMRT53k5yySWR7HJnjgaNpVQdTVGZBP0NgBf15udFFIipYCDwwloJ+5n
	 2LjymdGHXgjlJI3BRD7++RRMutEKb6/M9JfDp4oGF1jkRNyz9N4jR/nA1d4Vt12tc0
	 F/yyAP8PbskZnmJljEGPp81inRm46EsXrM3tfb+rI8O2ATL26gSUh/VRwmHhBM+cRw
	 1rqsuNw9Fe/PBWZfF5KR0Wq/b+KrdOQjMBQxWLlGyVajg+kFlrlIcTL6nutfRPOrSI
	 S9Pnf/Z7t3jxg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 21 Mar 2024 16:19:27 +0100
Subject: [PATCH] MAINTAINERS: update Benjamin's email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-bentiss_kernel-v1-1-eeaa04b4bfbc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP5P/GUC/x3MSwqAMAwA0atI1haaVvBzFRGpmmpQqjQignh3i
 8u3mHlAKDIJNNkDkS4W3kMC5hmMiwszKZ6SwWhTaGtQDRROFulXioE2VVvEynssrXOQoiOS5/s
 ftt37fj60LWJgAAAA
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711034376; l=2226;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=JagbLAWs5oV14b4pWzc+FAMEcZLOG8pm8iM+Ow8+Yi8=;
 b=idxzU9NqEHxAzS692QigZ1cfATnvQkTmfk4T7+2MITO9upCXANUoonubIkHGuOE/CNc05KzKP
 BQ6RMsjI1tqBxtfkSKaZ4sXrFK8D88kJpRGnbyEkvI4qhc3JZN6I6Di
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Update my email address to the kernel.org one, as it's getting
more convenient this way.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Basically it's getting easier for me to use the kernel.org address
instead of my company's one. So let's do it.

Note sure if I should go through the whole tree to change the different
occurences of my email, but worse case this can happen in a separate
patch.
---
 .mailmap    | 2 ++
 MAINTAINERS | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index e90797de3256..25019ddf467c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -96,6 +96,8 @@ Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
 Ben Widawsky <bwidawsk@kernel.org> <ben.widawsky@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
 Benjamin Poirier <benjamin.poirier@gmail.com> <bpoirier@suse.de>
+Benjamin Tissoires <bentiss@kernel.org> <benjamin.tissoires@gmail.com>
+Benjamin Tissoires <bentiss@kernel.org> <benjamin.tissoires@redhat.com>
 Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
 Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@linaro.org>
 Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@sonymobile.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index c50e72258ba9..52bb6f2c3e7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9546,7 +9546,7 @@ F:	kernel/power/
 
 HID CORE LAYER
 M:	Jiri Kosina <jikos@kernel.org>
-M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
+M:	Benjamin Tissoires <bentiss@kernel.org>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
@@ -22685,7 +22685,7 @@ F:	drivers/usb/host/ehci*
 
 USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
 M:	Jiri Kosina <jikos@kernel.org>
-M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
+M:	Benjamin Tissoires <bentiss@kernel.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git

---
base-commit: 3e78a6c0d3e02e4cf881dc84c5127e9990f939d6
change-id: 20240321-bentiss_kernel-93118ff173aa

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


